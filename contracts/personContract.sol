
//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.24;

contract Person{
    
    string internal personName = "";
    uint internal personAge = 0;

    function setPersonName(string memory _name) virtual public {
        personName = _name;
    }

    function setPersonAge(uint _age) public virtual {
        personAge = _age;
    }

    function getPersonName () public view returns (string memory){
        return personName;
    }

    function getPersonAge () public view returns (uint){
        return personAge;
    }
}

contract ImportantPerson is Person{


    function setPersonName(string memory _name) public override {
        personName = string.concat("vip_", _name);
    }

    function setPersonAge(uint _age) public override {
        personAge = _age + 18;
    }

    // function revertImportance() public {
    //     isStillImportant = !isStillImportant;
    // }
}