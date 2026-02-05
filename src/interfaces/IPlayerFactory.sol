// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

interface IPlayerFactory {
    function ownerOf(uint256 playerId) external view returns (address);
}