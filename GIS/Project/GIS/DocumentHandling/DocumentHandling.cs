using System.Collections.Generic;
using Microsoft.Office.Interop.Word;
using System.IO;

namespace DocumentHandling
{
    public abstract class DocumentHandling
    {
        public const string DEFAULT_BLANK = "";
        public const string DEFAULT_VALUE = "...";

        private Dictionary<string, BookmarkReplaced> _parameters;

        private _Application _application;

        public Dictionary<string, BookmarkReplaced> Parameters
        {
            get
            {

                if (_parameters == null)
                {
                    _parameters = new Dictionary<string, BookmarkReplaced>();
                }
                return _parameters;
            }
            set { _parameters = value; }
        }

        public _Application Application
        {
            get
            {
                if (_application == null)
                {
                    _application = new ApplicationClass();
                }
                return _application;
            }
        }

        public DocumentHandling() { }

        public abstract void SettingParam(string name, object value);

        public void Generate(string input, string output)
        {
            _Document doc = null;
            try
            {
                doc = OpenDocument(input);
                Generate(doc);
                SaveDocument(doc, output);
            }
            finally
            {
                if (doc != null)
                {
                    CloseDocument(doc);
                }
            }
        }

        protected void Generate(_Document document)
        {
            Bookmarks bookmarks = document.Bookmarks;
            foreach (Bookmark bookmark in bookmarks)
            {
                string bookmarkName = bookmark.Name;
                if (Parameters.ContainsKey(bookmarkName))
                {
                    BookmarkReplaced bookmarkReplaced = Parameters[bookmarkName];
                    switch (bookmarkReplaced.Type)
                    {
                        case ReplaceType.InLine:
                            InLineValue inLineValue = Parameters[bookmarkName].Value as InLineValue;
                            bookmark.Range.Text = inLineValue.Item;
                            break;
                        case ReplaceType.List:
                            ListValue listValue = Parameters[bookmarkName].Value as ListValue;
                            if (listValue.Items.Count == 1)
                            {
                                bookmark.Range.Text = listValue.Items[0];
                            }
                            else if (listValue.Items.Count >= 1)
                            {
                                object listStyle = listValue.ListStyle;
                                object range = bookmark.Range;
                                for (int i = listValue.Items.Count - 1; i >= 0; i--)
                                {
                                    if (i == listValue.Items.Count - 1)
                                    {
                                        bookmark.Range.Text = listValue.Items[i];
                                        bookmark.Range.set_Style(ref listStyle);
                                        bookmark.Range.SetListLevel(listValue.ListLevel);
                                    }
                                    else
                                    {
                                        Paragraph paragraph = document.Content.Paragraphs.Add(ref range);
                                        paragraph.Range.InsertParagraphAfter();
                                        paragraph.Range.Text = listValue.Items[i];
                                        paragraph.Range.set_Style(ref listStyle);
                                        paragraph.Range.SetListLevel(listValue.ListLevel);
                                        range = paragraph.Range;
                                    }
                                }
                            }
                            break;
                        case ReplaceType.Table:
                            TableValue tableValue = Parameters[bookmarkName].Value as TableValue;
                            int nRowData = tableValue.Items.Count;
                            Rows rows = bookmark.Range.Tables[1].Rows;
                            for (int i = 0; i < nRowData; i++)
                            {
                                List<string> rowData = tableValue.Items[i];
                                object row = rows[rows.Count];
                                Row currentRow = rows.Add(ref row);
                                int nCol = currentRow.Cells.Count;
                                int nColData = rowData.Count;
                                for (int j = 0; j < nColData && j < nCol; j++)
                                {
                                    currentRow.Cells[j + 1].Range.Text = rowData[j];
                                }
                            }
                            // remove last row
                            bookmark.Range.Tables[1].Rows[bookmark.Range.Tables[1].Rows.Count].Delete();
                            break;
                    }
                }
            }
        }

        private _Document OpenDocument(string input)
        {
            object filePath = input;
            object missing = System.Reflection.Missing.Value;
            object t = true;
            _Document openedDocument =
                Application.Documents.Open(
                    ref filePath, ref missing, ref t, ref missing,
                               ref missing, ref missing, ref missing, ref missing,
                               ref missing, ref missing, ref missing, ref missing,
                               ref missing, ref missing, ref missing, ref missing);
            return openedDocument;
        }

        private void CloseDocument(_Document document)
        {
            object saveChanges = WdSaveOptions.wdDoNotSaveChanges;
            object missing = System.Reflection.Missing.Value;
            document.Close(ref saveChanges, ref missing, ref missing);
            Application.Quit(ref saveChanges, ref missing, ref missing);
        }

        private void SaveDocument(_Document document, string output)
        {
            object missing = System.Reflection.Missing.Value;
            Directory.CreateDirectory(Path.GetDirectoryName(output));
            object filePath = output;
            document.SaveAs(ref filePath, ref missing, ref missing, ref missing,
                               ref missing, ref missing, ref missing, ref missing,
                               ref missing, ref missing, ref missing, ref missing,
                               ref missing, ref missing, ref missing, ref missing);
        }
    }
}