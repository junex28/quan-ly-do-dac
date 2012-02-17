////////////////////////////////////////////////////////////////////////////////
//
// Copyright © 2012 NguyenTanThuong
//
////////////////////////////////////////////////////////////////////////////////

dojo.provide("com.esri.solutions.jsviewer.Pagination");

dojo.require("dijit._Widget");
dojo.require("dijit._Templated");

// I18N
dojo.require("dojo.i18n");
dojo.requireLocalization("com.esri.solutions.jsviewer", "PaginationStrings");

dojo.declare("com.esri.solutions.jsviewer.Pagination", 
	[dijit._Widget, dijit._Templated], 
	{    
	constructor: function(/*Object*/ params) {		
		//console.log("Pagination constructor");
		},
	
	templatePath: dojo.moduleUrl("com.esri.solutions.jsviewer", "templates/Pagination.html"),
    
	i18nStrings: null,
	
	name:"",
	
    currentPage: 1,
    
    totalPages: 0,
	
	rowPerPage : 10,
	
	options:  null,
    
    postMixInProperties: function(){
        //console.log("Pagination::postMixInProperties");
		// Init i18n
	        this.i18nStrings = dojo.i18n.getLocalization("com.esri.solutions.jsviewer", "PaginationStrings");
	        this.first = this.i18nStrings.first;
			this.last = this.i18nStrings.last;
			this.prev = this.i18nStrings.prev;
			this.next = this.i18nStrings.next;
			this.pageNumInfoNode = this.i18nStrings.pageNumInfoNode;
			
    },
    
    postCreate: function(){
		try {
			this.inherited(arguments);
			
			dojo.parser.parse(this.domNode);
			
			this.prevNode = dojo.query(".prevNode", this.domNode)[0];			
			this.firstNode = dojo.query(".firstNode", this.domNode)[0];
			this.nextNode = dojo.query(".nextNode", this.domNode)[0];
			this.lastNode = dojo.query(".lastNode", this.domNode)[0];
			this.pageNumInfoNode = dojo.query(".pageNumInfoNode", this.domNode)[0];
			
			this.refresh();
			console.log("end post create");
		}catch(err){
			console.log("postCreate" + err);
   
		}
		
    },
    
    onFirstClick: function(evt){
        this.currentPage = 1;
        this.refresh();
        this.onPageChange(this.currentPage, this.options);
    },
    
    onPrevClick: function(evt){
        this.currentPage = this.currentPage - 1;
        this.refresh();
        this.onPageChange(this.currentPage, this.options);
    },
	
    onNextClick: function(evt){
        this.currentPage = this.currentPage + 1;
        this.refresh();
        this.onPageChange(this.currentPage, this.options);
    },
	
    onLastClick: function(evt){
        this.currentPage = this.totalPages;
        this.refresh();
        this.onPageChange(this.currentPage, this.options);
    },
	
	onPageChange: function (currPage, options) {  
        // User function called. passes the currentPage  
    }, 
	
	refresh: function () {  
	try{
		 if(this.currentPage <= 0) this.currentPage =1;  
        this.pageNumInfoNode.innerHTML = this.currentPage + " / " + this.totalPages;  
  
        if(this.currentPage == 1) {  
            this.prevNode.style.display = "none";  
            this.firstNode.style.display = "none";  
        } else {  
            this.prevNode.style.display = "";  
            this.firstNode.style.display = "";  
        }  
  
        if(this.currentPage >= this.totalPages) {  
            this.nextNode.style.display = "none";  
            this.lastNode.style.display = "none";  
        } else {  
            this.nextNode.style.display = "";  
            this.lastNode.style.display = "";  
        }  
	}catch(err){
		console.error("Pagination refresh" + err);	
	}         
    },  
	
	setPageInfo: function(current, total){
			this.currentPage = current;
			this.totalPages = total;			
			var msg = this.i18nStrings.pageNumInfoNode;
			msg = dojo.string.substitute(msg, [this.currentPage,this.totalPages]);
			this.pageNumInfoNode.innerHTML = msg;
			this.refresh();	
	},
	
	setTotalPage:function(total){
		this.totalPages = total;	
	},
	
	setCurrentPage:function(current){
		this.currentPage = current; 
	},
	
	setRowPerPage:function (rowPerPage){
		this.rowPerPage = rowPerPage	
	}
	,
	setOptions:function (options){
		this.options = options;
		
	}
	
});
