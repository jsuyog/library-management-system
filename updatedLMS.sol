//SPDX-License-Identifier: MIT
pragma solidity >0.5.0;

contract librarymgmt{

    uint16 private id = 0;
    struct Book{
        uint16 id;
        string bname;
        address curr_owner;
    }

    Book[] books;

    mapping(uint16=>address) public addOwner;
    mapping(address=>uint) private userBookCount;
    //mapping(address=>mapping(uint=>Book)) ownerOfBook;

    function addBook(string memory _bname) public {
        id++;
        books.push(Book(id,_bname,msg.sender));
        // ownerOfBook[msg.sender] = 
        // addOwner[id] = msg.sender;
        userBookCount[msg.sender]++;
    }

    function userBooks() public view returns(uint){
        return userBookCount[msg.sender];
    }

    function bookTransfer(uint16 _id) public {
        require(addOwner[_id] != msg.sender,"YOU HAVE THE BOOK");
        addOwner[_id] = msg.sender;
        books[_id-1].curr_owner = msg.sender;
    }

    function ownerOfBook(uint16 _id)public view returns(address){
        return addOwner[_id];
    }

    function getDetails(uint16 _id) public view returns(uint16 bid,string memory book_name,address current_owner){
        return(books[_id-1].id,books[_id-1].bname,books[_id-1].curr_owner);
    }

    function totalBooks() public view returns(uint16){
        return uint16(books.length);
    }
}    
 
