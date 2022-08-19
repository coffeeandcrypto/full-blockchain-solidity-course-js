// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier:  MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    address public immutable i_owner;

    constructor(){
        i_owner = msg.sender;
    }

    function fund() public payable {
        //payable is what turns the button red
        //smart contracts can hold funds just like wallets
        //reverting returns the gas fee paid 
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough"); //1e18 = 1*10 **18 = the value in wei (use eth converter tool)
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;

    }

    function Withdraw() public onlyOwner {
        //require(msg.sender == owner, "Sender Is Not Owner!");

        // starting index, ending index, step amount
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex ++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;

        }
        //reset the array
        funders = new address [](0);

        /*//withdraw the funds
        //transfer
        payable(msg.sender).transfer(address(this).balance);

        //send
        bool sendSuccess = payable(msg.sender).send(address(this).balance);
        require(sendSuccess, "Send Failed");
        */

        //call
        (bool callSuccess, ) = payable(msg.sender).call{value:  address(this).balance}("");
        require(callSuccess, "Call Failed");

    }

    modifier onlyOwner {
        require(msg.sender == i_owner, "Sender Is Not Owner!");
        _;
    }
}
