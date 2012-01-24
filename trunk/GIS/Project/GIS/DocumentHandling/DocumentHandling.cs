using System.Collections;
using Microsoft.Office.Interop.Word;

namespace DocumentHandling
{
    public class DocumentHandling
    {
        private Hashtable _parameters;
        
        public Hashtable Parameters
        {
            get { return _parameters; }
            set { _parameters = value; }
        }

        public bool Generate(string input, string output)
        {
            _Document doc = OpenDocument(input);
            if (doc == null)
            {
                return false;
            }
            try
            {
                Generate(doc);
                SaveDocument(doc, output);
                CloseDocument(doc);
                return true;
            }
            catch
            {
                return false;
            }
        }

        private void Generate(_Document document)
        {
            Bookmarks allBookmark = document.Bookmarks;
            foreach (Bookmark bookmark in allBookmark)
            {
                string bookmarkName = bookmark.Name;
                if (Parameters.Contains(bookmarkName))
                {
                    bookmark.Range.Text = Parameters[bookmarkName].ToString();
                }
            }
        }

        private _Document OpenDocument(string input)
        {
            try
            {
                _Application application = new ApplicationClass();
                object filePath = input;
                object missing = System.Reflection.Missing.Value;
                object t = true;
                _Document openedDocument =
                    application.Documents.Open(
                        ref filePath, ref missing, ref t, ref missing,
                                   ref missing, ref missing, ref missing, ref missing,
                                   ref missing, ref missing, ref missing, ref missing,
                                   ref missing, ref missing, ref missing, ref missing);
                return openedDocument;
            }
            catch
            {
                return null;
            }
        }

        private void CloseDocument(_Document document)
        {
            object saveChanges = WdSaveOptions.wdDoNotSaveChanges;
            object missing = System.Reflection.Missing.Value;
            document.Close(ref saveChanges, ref missing, ref missing);
        }

        private void SaveDocument(_Document document, string output)
        {
            object missing = System.Reflection.Missing.Value;
            object filePath = output;
            document.SaveAs(ref filePath, ref missing, ref missing, ref missing,
                               ref missing, ref missing, ref missing, ref missing,
                               ref missing, ref missing, ref missing, ref missing,
                               ref missing, ref missing, ref missing, ref missing);
        }
    }
}
