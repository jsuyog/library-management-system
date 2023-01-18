//SPDX-License-Identifier: MIT
pragma solidity >0.5.0;

contract librarymgmt{
    address private librarian;
    string[] private bo;
    uint16 private totalBooks;

    struct Book{
        string name;
        string genere;
    }

    mapping(address=>Book) public addresstobook;
    mapping(address=>uint16) public addresstoNoBooks;

    Book[] books;

    constructor(){
        librarian = msg.sender;
    }

    function createBook(string memory _name,string memory _genere) public {
        require(msg.sender == librarian,"NOT AUTH");
        books.push(Book(_name,_genere));
        totalBooks++;
    }
    function totalNoBooks() public view returns(uint16){
        return totalBooks;
    }
    function issueBooks(address _to,string memory _name) public {
        require(msg.sender == librarian,"NOT AUTH");
        require(addresstoNoBooks[_to] == 0,"ONLY ONE BOOK ALLOWED AT A TIME");
        for(uint16 i  = 0;i < books.length;i++){
            if(keccak256(abi.encodePacked(_name)) == keccak256(abi.encodePacked(books[i].name))){
                addresstobook[_to] = books[i];
                addresstoNoBooks[_to]++; 
            }
        }
    }
    function allBooks() public returns(string[] memory){
        if(bo.length == totalBooks){
            return bo;
        }else{
            for(uint16 i = 0;i < books.length;i++){
            bo.push(books[i].name);
        }
        }
        return bo;
    }
    function bookIssuedtoAddr(address _addr) public view returns(string memory name,string memory genere){
        return(addresstobook[_addr].name,addresstobook[_addr].genere);
    }
    function returnBook() public {
        require(addresstoNoBooks[msg.sender] > 0,"Nothing In Here");
        delete(addresstobook[msg.sender]);
        addresstoNoBooks[msg.sender]--;
    }
}
