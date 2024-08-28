//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.24;

import {Person, ImportantPerson} from "contracts/personContract.sol";

/**
*PersonManager performs CRUD operations on an array of Person/ImportantPerson
*
**/

contract PersonManager{

    Person[] people;


    function addNewPerson(string memory _newPersonName, uint _newPersonAge, bool _isImportant) public {
        
        Person newPerson = !_isImportant? new Person(): new ImportantPerson();
        newPerson.setPersonName(_newPersonName);
        newPerson.setPersonAge(_newPersonAge);

        people.push(newPerson);
    }

    

    function readPersonByName(string memory _personName) public view returns(string memory){
        int targetPersonIndex = findPersonByName(_personName);

        return targetPersonIndex >= 0? people[uint(targetPersonIndex)].getPersonName(): "null";
    }

    function isSameString(string memory _a, string memory _b) private pure returns(bool){
        if ( keccak256(bytes(_a)) == keccak256(bytes(_b))){
            return true;
        }else {
            return false;
        }
    }

    function findPersonByName(string memory _personName) private view returns(int){
        int foundIndex = -1; //-1 is not found

        for (uint i = 0; i < people.length; i++){
            if (isSameString(people[i].getPersonName(), _personName)){
                foundIndex = int(i);
                break;
            }
        }
        
        return foundIndex;
    }

    function readAllPerson() public view returns (string[] memory){
        string[] memory allPeopleNames = new string[](people.length);

        for (uint i = 0; i < people.length;i++){
            allPeopleNames[i] = people[i].getPersonName();
        }

        return allPeopleNames;
    }

    function updatePersonByName(string memory _personName, string memory _newPersonName) public returns(bool){
        //ensure that no other person has the new name
        //update name at found index
        
        bool status = false;

        int foundPersonIndex = findPersonByName(_personName);

        if (foundPersonIndex >= 0){
            people[uint(foundPersonIndex)].setPersonName(_newPersonName);

            status = isSameString(_newPersonName, people[uint(foundPersonIndex)].getPersonName());

        }

       
        return status;

    }

    function deletePersonByName(string memory _personName) public returns(int8){
        // create a new array with all entries except the deleted person with corresponding name

        int8 deleted = -1; //-1 not found, 0 found but not deleted, 1 found and deleted

        int foundIndex = findPersonByName(_personName);

        uint startPeopleSize = people.length;

        if (foundIndex > -1){

            deleted++;

            for (uint i = uint(foundIndex); i < people.length - 1; i++){
                people[i] = people[i + 1];
            }

            people.pop();

            if (startPeopleSize < people.length) deleted++;
        }

        return deleted;


    }



}