//SPDX-License-Identifier: None

pragma solidity 0.8.19;

import {ERC20Burnable, ERC20} from "@openzeppelin-contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin-contracts/access/Ownable.sol";

/*
 This is considered an 
 Exogenous -> Not backed by a inter-dependent collateral, i.e Unlike UST / Luna
 Decentralized -> Not owned by any company/govt, i.e Unlike USDC, USDT
 Anchored (pegged) -> Pegged to USD
 Crypto Collateralized low volitility coin -> Backed by ETH, BTC as collateral
*/
contract DecentralizedStableCoin is ERC20Burnable, Ownable {
    constructor() ERC20("SingamStableCoin", "SSC") {}

    // The DSC Engine contract, will be the owner for this contract.
    // therefore solely responisble for minting and buring the Singam stable coin.
    // Therefore making this stable coin a Decentralized, Algorithmic stable Coin
    function burn(uint256 amount) public override onlyOwner {
        uint256 balance = this.balanceOf(msg.sender);
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
