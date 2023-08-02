//SPDX-License-Identifier: None

pragma solidity ^0.8.14;

import {ERC20Burnable, ERC20} from "@openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin-contracts/contracts/access/Ownable.sol";

/*
 This is considered an 
 Exogenous -> Not backed by a inter-dependent collateral, i.e Unlike UST / Luna
 Decentralized -> Not owned by any company/govt, i.e Unlike USDC, USDT
 Anchored (pegged) -> Pegged to USD
 Crypto Collateralized low volitility coin -> Backed by ETH, BTC as collateral
*/
contract DecentralizedStableCoin is ERC20Burnable, Ownable {
    constructor() ERC20("SingamStableCoin", "SSC") {}

    function burn(uint amount) public override onlyOwner {
        uint balance = this.balanceOf(msg.sender);
        require(amount >= 0, "DecentralizedStableCoin: amount < 0");
        require(
            balance >= amount,
            "DecentralizedStableCoin: Insufficient Balance"
        );

        super.burn(amount);
    }

    function mint(
        address _to,
        uint256 _amount
    ) external onlyOwner returns (bool) {
        require(_to != address(0), "DecentralizedStableCoin: NonZeroAddress");

        require(
            _amount > 0,
            "DecentralizedStableCoin: AmountMustBeMoreThanZero"
        );

        _mint(_to, _amount);
        return true;
    }
}
