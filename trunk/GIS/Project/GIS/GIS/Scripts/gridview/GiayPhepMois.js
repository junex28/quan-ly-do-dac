$(document).ready(function() {
    GiayPhepMois.setupGrid($("#grid"), $("#pager"));
});

var GiayPhepMois = {
    setupGrid: function(grid, pager) {
        grid.jqGrid({
            url: "ListData",
            mtype: "GET",
            datatype: "json",
            colNames: ['', 'Mã giấy phép', 'Số giấy phép' , 'Tên Tổ Chức', 'Ngày xin phép'],
            colModel: [
                { name: 'Action', index: 'Action', width: 30, align: 'left', sortable: false, resizable: false },
                { name: 'MaGiayPhepHoatDong', index: 'MaGiayPhepHoatDong', width: 40, align: 'left', sortable: true },
                { name: 'SoGiayPhep', index: 'SoGiayPhep', width: 40, align: 'left', sortable: false },
                { name: 'TenToChuc', index: 'TenToChuc', width: 200, align: 'left', sortable: true},
                { name: 'NgayXinPhep', index: 'NgayXinPhep', width: 200, align: 'left', sortable: true}],
            page: 1,
            rowNum: 10,
            rowList: [10, 20, 50],
            pager: pager,
            sortname: 'MaGiayPhepHoatDong',
            sortorder: "asc",
            viewrecords: true,
            multiselect: false,
            width: '100%',
            height: '100%',
            autowidth: true,
            rownumbers: true,
            caption: 'Quản Lý giấy phép mới'
        });

    }
};
