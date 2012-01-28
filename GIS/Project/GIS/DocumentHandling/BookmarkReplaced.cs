using System.Collections.Generic;

namespace DocumentHandling
{
    public enum ReplaceType
    {
        InLine,
        List,
        Table
    }

    public class BookmarkReplaced
    {
        private ReplaceType _type;
        private ReplaceValue _value;

        public ReplaceType Type
        {
            get { return _type; }
            set { _type = value; }
        }

        public ReplaceValue Value
        {
            get { return _value; }
            set { _value = value; }
        }
    }

    public abstract class ReplaceValue { }

    public class InLineValue : ReplaceValue
    {
        private string _item;

        public string Item
        {
            get { return _item; }
            set { _item = value; }
        }
    }

    public class TableValue : ReplaceValue
    {
        private List<List<string>> _items;

        public List<List<string>> Items
        {
            get
            {
                if (_items == null)
                {
                    _items = new List<List<string>>();
                }
                return _items;
            }
            set { _items = value; }
        }
    }

    public class ListValue : ReplaceValue
    {
        private short _listLevel;
        private string _listStyle;
        private List<string> _items;

        public short ListLevel
        {
            get { return _listLevel; }
            set { _listLevel = value; }
        }

        public string ListStyle
        {
            get { return _listStyle; }
            set { _listStyle = value; }
        }

        public List<string> Items
        {
            get
            {
                if (_items == null)
                {
                    _items = new List<string>();
                }
                return _items;
            }
            set { _items = value; }
        }
    }

    public class BookmarkReplacedFactory
    {
        static public BookmarkReplaced getInLineValue(string item)
        {
            BookmarkReplaced bookmarkReplaced = new BookmarkReplaced();
            bookmarkReplaced.Type = ReplaceType.InLine;
            InLineValue value = new InLineValue();
            value.Item = item;
            bookmarkReplaced.Value = value;
            return bookmarkReplaced;
        }

        static public BookmarkReplaced getListValue(string listStyle, short listLevel, List<string> items)
        {
            BookmarkReplaced bookmarkReplaced = new BookmarkReplaced();
            bookmarkReplaced.Type = ReplaceType.List;
            ListValue value = new ListValue();
            value.ListStyle = listStyle;
            value.ListLevel = listLevel;
            value.Items = items;
            bookmarkReplaced.Value = value;
            return bookmarkReplaced;
        }

        static public BookmarkReplaced getTableValue(List<List<string>> items)
        {
            BookmarkReplaced bookmarkReplaced = new BookmarkReplaced();
            bookmarkReplaced.Type = ReplaceType.Table;
            TableValue value = new TableValue();
            value.Items = items;
            bookmarkReplaced.Value = value;
            return bookmarkReplaced;
        }
    }
}
