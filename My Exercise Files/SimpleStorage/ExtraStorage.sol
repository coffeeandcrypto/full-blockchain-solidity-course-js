//  SPDX-License-Identifier:  MIT

pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

// "is" means that this ExtraStorage contract is going to inherit everything that is in the SimpleStorage.sol contract
// can see this by deploying this contract when the ExtraStorage contract is empty and can see all the functions and values that are part of the SimpleStorage contract
contract ExtraStorage is SimpleStorage{
    // add 5 to any number we give it 
    // have to override the function in the original contract using override or virtual override
    function store(uint256 _favoriteNumber) public override {
        favoriteNumber = _favoriteNumber + 5;
    }

}