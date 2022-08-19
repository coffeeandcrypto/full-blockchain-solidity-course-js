// SPDX-License-Identifier:  MIT

pragma solidity ^0.8.8;

    // instructions for this are here: https://docs.chain.link/docs/get-the-latest-price/#solidity
    // uses the github link and npm to "add" this whole thing to the code without having to add the whole thing
    import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {


    function GetPrice() internal view returns (uint256) {
        //we are interacting with a contract outside
        // ABI
        // address 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e

        // this is creating an AggregatorV3Interface variable named priceFeed
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 price,,,) = priceFeed.latestRoundData();
        //this returns the price of ETH in terms of USD
        return uint256(price * 1e10); // 1**10 == 10000000000
    }

    function getVersion() internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
        uint256 ethPrice = GetPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

}