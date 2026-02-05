// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {Initializable} from "openzeppelin-upgradeable/proxy/utils/Initializable.sol";
import {IPlayerFactory} from "./interfaces/IPlayerFactory.sol";

contract Player is Initializable {

    uint256 public playerId;
    IPlayerFactory public immutable playerFactory;

    error NotPlayer();

    constructor(address playerFactory_) {
        playerFactory = IPlayerFactory(playerFactory_);
    }

    function initialize(uint256 playerId_) external initializer {
        playerId = playerId_;
    }

    function joinMatch(uint256 matchId_) external onlyPlayer {}
    
    modifier onlyPlayer() {
        if (msg.sender != playerFactory.ownerOf(playerId)) revert NotPlayer();
        _;
    }
}
