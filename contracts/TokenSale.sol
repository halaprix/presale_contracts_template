// SPDX-License-Identifier: MIT
pragma solidity ^0.5.5;

import "@openzeppelin/contracts/crowdsale/Crowdsale.sol";
import "@openzeppelin/contracts/crowdsale/validation/WhitelistCrowdsale.sol";

contract TokenSale is Crowdsale, WhitelistCrowdsale {
    mapping(address => bool) public hasPurchased;

    constructor(
        uint256 rate, // rate for the lowest tier -> 5000 . 2e14 wei gives 1 token (1e9 bits of NLZ)
        address payable wallet,
        IERC20 token
    ) public Crowdsale(rate, wallet, token) WhitelistCrowdsale() {}

    // The additional "div(1e9)" is due to the difference of decimals. 
    // Defined rate (5000) would work for 18 decimal token
    function _getTokenAmount(uint256 weiAmount)
        internal
        view
        returns (uint256)
    {
        if (weiAmount < 15e15) {
            return weiAmount.mul(rate()).mul(1000).div(1000).div(1e9);
        } else if (weiAmount < 15e16) {
            return weiAmount.mul(rate()).mul(666).div(1000).div(1e9);
        } else if (weiAmount < 15e17) {
            return weiAmount.mul(rate()).mul(444).div(1000).div(1e9);
        } else {
            return weiAmount.mul(rate()).mul(287).div(1000).div(1e9);
        }
    }

    function buyTokens(address beneficiary) public payable {
        require(!hasPurchased[beneficiary], "You've already purchased");
        hasPurchased[beneficiary] = true;
        super.buyTokens(beneficiary);
    }
}
