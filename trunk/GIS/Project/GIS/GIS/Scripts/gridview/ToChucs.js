$(document).ready(function() {
    ToChucs.setupGrid($("#grid"), $("#pager"));
});

var ToChucs = {
        setupGrid: function(grid, pager) {
            grid.jqGrid({
                url: "ListData",
                mtype: "GET",
                datatype: "json",
                colNames: ['','Mã Tổ Chức','Tên Tổ Chức','Trụ Sở Chính'],
                colModel: [
                { name: 'Action', index: 'Action',  width: 30, align: 'left', sortable: false, resizable: false },
                { name: 'MaToChuc', index: 'MaToChuc', width: 40, align: 'left', sortable: false },
                { name: 'TenToChuc', index: 'TenToChuc', width: 40, align: 'left', sortable: true },
                { name: 'TruSoChinh', index: 'TruSoChinh', width: 200, align: 'left', sortable: true}],
                page: 1,
                rowNum: 10,
                rowList: [10, 20, 50],
                pager: pager,
                sortname: 'MaToChuc',
                sortorder: "asc",
                viewrecords: true,
                multiselect: false,
                width: '100%',
                height: '100%',
                autowidth: true,
                rownumbers: true,
                caption: 'Quản Lý Tổ Chức'
            });
          
        }
    };
