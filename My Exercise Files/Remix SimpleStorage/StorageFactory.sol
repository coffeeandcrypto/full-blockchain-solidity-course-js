//  SPDX-License-Identifier:  MIT

pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);

    }

    function sfStore (uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        //always going to need address of a contract and the ABI (application binary interface) of the contract
        //we automatically get the ABI of the SimpleStorage.sol contract by importing it the way we are importing it

        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);

    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        return simpleStorageArray[_simpleStorageIndex].retrieve();
        
    }
}