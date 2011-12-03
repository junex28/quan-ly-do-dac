drop database QLDDBD
go
create database QLDDBD
go
use	QLDDBD
go
/*
if exists(select 1 from sys.sysforeignkey where role='FK_BAOCAOHO_REFERENCE_TOCHUC') then
    alter table BAOCAOHOATDONG
       delete foreign key FK_BAOCAOHO_REFERENCE_TOCHUC
end if;
go
if exists(select 1 from sys.sysforeignkey where role='FK_CONGDOAN_REFERENCE_CONGTRIN') then
    alter table CONGDOANTHUCHIEN
       delete foreign key FK_CONGDOAN_REFERENCE_CONGTRIN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_CONGDOAN_REFERENCE_GIAYPHEP') then
    alter table CONGDOANTHUCHIEN
       delete foreign key FK_CONGDOAN_REFERENCE_GIAYPHEP
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_DANGKYHO_REFERENCE_GIAYPHEP') then
    alter table DANGKYHOATDONG
       delete foreign key FK_DANGKYHO_REFERENCE_GIAYPHEP
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_DANGKYHO_REFERENCE_HOATDONG') then
    alter table DANGKYHOATDONG
       delete foreign key FK_DANGKYHO_REFERENCE_HOATDONG
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_GIAYPHEP_REFERENCE_TOCHUC') then
    alter table GIAYPHEPHOATDONG
       delete foreign key FK_GIAYPHEP_REFERENCE_TOCHUC
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_NHANLUC_REFERENCE_TOCHUC') then
    alter table NHANLUC
       delete foreign key FK_NHANLUC_REFERENCE_TOCHUC
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_QUANHUYE_REFERENCE_TINHTHAN') then
    alter table QUANHUYEN
       delete foreign key FK_QUANHUYE_REFERENCE_TINHTHAN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SANPHAM_REFERENCE_CONGTRIN') then
    alter table SANPHAM
       delete foreign key FK_SANPHAM_REFERENCE_CONGTRIN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SANPHAM_REFERENCE_QUANHUYE') then
    alter table SANPHAM
       delete foreign key FK_SANPHAM_REFERENCE_QUANHUYE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SANPHAM_REFERENCE_LOAISANP') then
    alter table SANPHAM
       delete foreign key FK_SANPHAM_REFERENCE_LOAISANP
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_THAMDINH_REFERENCE_GIAYPHEP') then
    alter table THAMDINH
       delete foreign key FK_THAMDINH_REFERENCE_GIAYPHEP
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_THIETBI_REFERENCE_TOCHUC') then
    alter table THIETBI
       delete foreign key FK_THIETBI_REFERENCE_TOCHUC
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_TOCHUC_REFERENCE_LOAIHINH') then
    alter table TOCHUC
       delete foreign key FK_TOCHUC_REFERENCE_LOAIHINH
end if;

if exists(
   select 1 from sys.systable 
   where table_name='BAOCAOHOATDONG'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table BAOCAOHOATDONG
end if;

if exists(
   select 1 from sys.systable 
   where table_name='CONGDOANTHUCHIEN'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table CONGDOANTHUCHIEN
end if;

if exists(
   select 1 from sys.systable 
   where table_name='CONGTRINH'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table CONGTRINH
end if;

if exists(
   select 1 from sys.systable 
   where table_name='DANGKYHOATDONG'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table DANGKYHOATDONG
end if;

if exists(
   select 1 from sys.systable 
   where table_name='GIAYPHEPHOATDONG'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table GIAYPHEPHOATDONG
end if;

if exists(
   select 1 from sys.systable 
   where table_name='HOATDONG'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table HOATDONG
end if;

if exists(
   select 1 from sys.systable 
   where table_name='LOAIHINHTOCHUC'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table LOAIHINHTOCHUC
end if;

if exists(
   select 1 from sys.systable 
   where table_name='LOAISANPHAM'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table LOAISANPHAM
end if;

if exists(
   select 1 from sys.systable 
   where table_name='NHANLUC'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table NHANLUC
end if;

if exists(
   select 1 from sys.systable 
   where table_name='QUANHUYEN'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table QUANHUYEN
end if;

if exists(
   select 1 from sys.systable 
   where table_name='SANPHAM'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table SANPHAM
end if;

if exists(
   select 1 from sys.systable 
   where table_name='THAMDINH'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table THAMDINH
end if;

if exists(
   select 1 from sys.systable 
   where table_name='THIETBI'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table THIETBI
end if;

if exists(
   select 1 from sys.systable 
   where table_name='TINHTHANH'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table TINHTHANH
end if;

if exists(
   select 1 from sys.systable 
   where table_name='TOCHUC'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table TOCHUC
end if;
*/
/*==============================================================*/
/* Table: BAOCAOHOATDONG                                        */
/*==============================================================*/
create table BAOCAOHOATDONG 
(
   MABAOCAOHOATDONG     int                            not null,
   MATOCHUC             int,
   NAM                  varchar(4),
   DOANHTHU             money,
   NOPNGANSACH          money,
   DANHSACHCONGTRINH    xml,
   TEPDINHKEM           varchar(500),
   constraint PK_BAOCAOHOATDONG primary key clustered (MABAOCAOHOATDONG)
);

/*==============================================================*/
/* Table: CONGDOANTHUCHIEN                                      */
/*==============================================================*/
create table CONGDOANTHUCHIEN 
(
   MACONGDOAN           int                            not null,
   SOGIAYPHEP           varchar(20)						not null,
   MACONGTRINH          int,
   NGAYBATDAU           date,
   NGAYKETTHUC          date,
   constraint PK_CONGDOANTHUCHIEN primary key clustered (MACONGDOAN)
);

/*==============================================================*/
/* Table: CONGTRINH                                             */
/*==============================================================*/
create table CONGTRINH 
(
   MACONGTRINH          int                            not null,
   TENCONGTRINH         varchar(250),
   CHUDAUTU             varchar(250),
   DONVINGHIEMTHU       varchar(250),
   THOIGIANBATDAU       date,
   THOIGIANKETTHUC      date,
   GHICHU              text,
   DADUYET              bit,
   constraint PK_CONGTRINH primary key clustered (MACONGTRINH)
);

/*==============================================================*/
/* Table: DANGKYHOATDONG                                        */
/*==============================================================*/
create table DANGKYHOATDONG 
(
   MADANGKYHOATDONG     int                            not null,
   MAGIAYPHEPHOATDONG   int,
   LABOSUNG             bit,
   NGAYBOSUNG           date,
   DAXETDUYET           bit,
   MAHOATDONG           int,
   constraint PK_DANGKYHOATDONG primary key clustered (MADANGKYHOATDONG)
);

/*==============================================================*/
/* Table: GIAYPHEPHOATDONG                                      */
/*==============================================================*/
create table GIAYPHEPHOATDONG 
(
   MAGIAYPHEPHOATDONG   int                            not null,
   MATOCHUC             int,
   SOGIAYPHEP           varchar(20)        unique    ,
   NGAYCAPPHEP          date,
   NGAYHETHAN           date,
   NGAYGIAHAN           date,
   DAGIAHAN             bit,
   DABOSUNG             bit,
   LYDOXINPHEP          text,
   LYDOGIAHAN           text,
   LYDOCAPPHEP          text,
   CAMKETXINPHEP        text,
   CAMKETGIAHAN         text,
   CAMKETBOSUNG         text,
   TINHTRANG            int,
   MATHAMDINH           int,
   constraint PK_GIAYPHEPHOATDONG primary key clustered (MAGIAYPHEPHOATDONG),
   --constraint UK_GIAYPHEPHOATDONG unique non clustered (SOGIAYPHEP)
);

/*==============================================================*/
/* Table: HOATDONG                                              */
/*==============================================================*/
create table HOATDONG 
(
   MAHOATDONG           int                            not null,
   TENHOATDONG          varchar(250),
   constraint PK_HOATDONG primary key clustered (MAHOATDONG)
);

/*==============================================================*/
/* Table: LOAIHINHTOCHUC                                        */
/*==============================================================*/
create table LOAIHINHTOCHUC 
(
   MALOAIHINHTOCHUC     int                            not null,
   TENLOAIHINHTOCHUC    varchar(50),
   constraint PK_LOAIHINHTOCHUC primary key clustered (MALOAIHINHTOCHUC)
);

/*==============================================================*/
/* Table: LOAISANPHAM                                           */
/*==============================================================*/
create table LOAISANPHAM 
(
   MALOAISANPHAM        int                            not null,
   TENLOAISANPHAM       varchar(250),
   KIEUSANPHAM          int,
   DIENGIAI             text,
   constraint PK_LOAISANPHAM primary key clustered (MALOAISANPHAM)
);

/*==============================================================*/
/* Table: NHANLUC                                               */
/*==============================================================*/
create table NHANLUC 
(
   MANHANVIEN           int                            not null,
   MATOCHUC             int,
   HOTEN                varchar(100),
   CMND                 varchar(15),
   CHUCVU               varchar(50),
   DIACHI               text,
   TRINHDOHV            varchar(50),
   CHUYENNGANH          varchar(100),
   THAMNIEN             int,
   NGAYSINH             date,
   QUATRINHHOCTAP       text,
   QUATRINHCONGTAC      text,
   CHIUTRACHNHIEM       bit,
   TEPDINHKEM           text,
   constraint PK_NHANLUC primary key clustered (MANHANVIEN)
);

/*==============================================================*/
/* Table: QUANHUYEN                                             */
/*==============================================================*/
create table QUANHUYEN 
(
   MAQUANHUYEN          int                            not null,
   TENQUANHUYEN         varchar(50),
   MATINHTHANH          int,
   constraint PK_QUANHUYEN primary key clustered (MAQUANHUYEN)
);

/*==============================================================*/
/* Table: SANPHAM                                               */
/*==============================================================*/
create table SANPHAM 
(
   MASANPHAM            varchar(50)                    not null,
   MALOAISANPHAM        int,
   MACONGTRINH          int,
   MAQUANHUYEN          int,
   CAPHANHCHINH         int,
   constraint PK_SANPHAM primary key clustered (MASANPHAM)
);

/*==============================================================*/
/* Table: THAMDINH                                              */
/*==============================================================*/
create table THAMDINH 
(
   MATHAMDINH           varchar(50)                    not null,
   MAGIAYPHEPHOATDONG   int,
   NGUOITHAMDINH        text,
   NGUOIPHIATOCHUC      text,
   NGAYTHAMDINH         date,
   TINHHOPLE            text,
   NANGLUCNHANVIEN      text,
   NANGLUCTHIETBI       text,
   KETLUAN              text,
   KIENNGHI             text,
   LOAITHAMDINH         int,
   constraint PK_THAMDINH primary key clustered (MATHAMDINH)
);

/*==============================================================*/
/* Table: THIETBI                                               */
/*==============================================================*/
create table THIETBI 
(
   MATHIETBI            int                            not null,
   MATOCHUC             int,
   TENTHIETBI           varchar(250),
   SOLUONG              int,
   HANGSANXUAT          varchar(250),
   CONGNGHE             varchar(250),
   TINHTRANG            bit,
   GHICHU               text,
   TEPDINHKEM           text,
   constraint PK_THIETBI primary key clustered (MATHIETBI)
);

/*==============================================================*/
/* Table: TINHTHANH                                             */
/*==============================================================*/
create table TINHTHANH 
(
   MATINHTHANH          int                            not null,
   TENTINHTHANH         varchar(50),
   constraint PK_TINHTHANH primary key clustered (MATINHTHANH)
);

/*==============================================================*/
/* Table: TOCHUC                                                */
/*==============================================================*/
create table TOCHUC 
(
   MATOCHUC             int                            not null,
   MALOAIHINHTOCHUC     int,
   TENTOCHUC            varchar(250),
   GIAYPHEPKINHDOANH    varchar(15),
   NGUOIDAIDIEN         varchar(100),
   TRUSOCHINH           text,
   SOTAIKHOAN           varchar(15),
   DIENTHOAI            varchar(15),
   FAX                  varchar(15),
   EMAIL                varchar(250),
   TONGSOCANBO          int,
   NGAYXINPHEP          date,
   KICHHOAT             bit,
   TEPDINHKEM           text,
   constraint PK_TOCHUC primary key clustered (MATOCHUC)
);

alter table BAOCAOHOATDONG
   add constraint FK_BAOCAOHO_REFERENCE_TOCHUC foreign key (MATOCHUC)
      references TOCHUC (MATOCHUC)
      on update cascade
      on delete cascade;
go
alter table CONGDOANTHUCHIEN
   add constraint FK_CONGDOAN_REFERENCE_CONGTRIN foreign key (MACONGTRINH)
      references CONGTRINH (MACONGTRINH)
      on update cascade
      on delete cascade;
go
alter table CONGDOANTHUCHIEN
   add constraint FK_CONGDOAN_REFERENCE_GIAYPHEP foreign key (SOGIAYPHEP)
      references GIAYPHEPHOATDONG (SOGIAYPHEP)
      on update cascade
      on delete cascade;
go
alter table DANGKYHOATDONG
   add constraint FK_DANGKYHO_REFERENCE_GIAYPHEP foreign key (MAGIAYPHEPHOATDONG)
      references GIAYPHEPHOATDONG (MAGIAYPHEPHOATDONG)
      on update cascade
      on delete cascade;
go
alter table DANGKYHOATDONG
   add constraint FK_DANGKYHO_REFERENCE_HOATDONG foreign key (MAHOATDONG)
      references HOATDONG (MAHOATDONG)
      on update cascade
      on delete cascade;
go
alter table GIAYPHEPHOATDONG
   add constraint FK_GIAYPHEP_REFERENCE_TOCHUC foreign key (MATOCHUC)
      references TOCHUC (MATOCHUC)
      on update cascade
      on delete cascade;
go
alter table NHANLUC
   add constraint FK_NHANLUC_REFERENCE_TOCHUC foreign key (MATOCHUC)
      references TOCHUC (MATOCHUC)
      on update cascade
      on delete cascade;
go
alter table QUANHUYEN
   add constraint FK_QUANHUYE_REFERENCE_TINHTHAN foreign key (MATINHTHANH)
      references TINHTHANH (MATINHTHANH)
      on update cascade
      on delete cascade;
go
alter table SANPHAM
   add constraint FK_SANPHAM_REFERENCE_CONGTRIN foreign key (MACONGTRINH)
      references CONGTRINH (MACONGTRINH)
      on update cascade
      on delete cascade;
go
alter table SANPHAM
   add constraint FK_SANPHAM_REFERENCE_QUANHUYE foreign key (MAQUANHUYEN)
      references QUANHUYEN (MAQUANHUYEN)
      on update cascade
      on delete cascade;
go
alter table SANPHAM
   add constraint FK_SANPHAM_REFERENCE_LOAISANP foreign key (MALOAISANPHAM)
      references LOAISANPHAM (MALOAISANPHAM)
      on update cascade
      on delete cascade;
go
alter table THAMDINH
   add constraint FK_THAMDINH_REFERENCE_GIAYPHEP foreign key (MAGIAYPHEPHOATDONG)
      references GIAYPHEPHOATDONG (MAGIAYPHEPHOATDONG)
      on update cascade
      on delete cascade;
go
alter table THIETBI
   add constraint FK_THIETBI_REFERENCE_TOCHUC foreign key (MATOCHUC)
      references TOCHUC (MATOCHUC)
      on update cascade
      on delete cascade;
go
alter table TOCHUC
   add constraint FK_TOCHUC_REFERENCE_LOAIHINH foreign key (MALOAIHINHTOCHUC)
      references LOAIHINHTOCHUC (MALOAIHINHTOCHUC)
      on update cascade
      on delete cascade;
