// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {Clones} from "openzeppelin/proxy/Clones.sol";
import "openzeppelin/token/ERC721/ERC721.sol";
import "openzeppelin/access/Ownable2Step.sol";

import {Player} from "./Player.sol";

contract PlayerFactory is Ownable2Step, ERC721 {

    address public immutable PLAYER;
    uint256 public playerId;

    mapping(uint256 => address) public players;
    
    event PlayerCreated(address owner, uint256 playerId, address player);

    constructor(address owner_) Ownable(owner_) ERC721("Defi Arena Player", "DAP") {
        PLAYER = address(new Player(address(this)));
    }

    function createPlayer(address owner) external returns (address player) {
        // deploy a new account contract
        player = Clones.clone(PLAYER);
        Player(payable(player)).initialize(playerId);

        // mint an NFT to the user
        _mint(owner, playerId);

        players[playerId] = player;

        emit PlayerCreated(owner, ++playerId, player);
    }
}