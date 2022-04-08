// //
// // this script executes when you run 'yarn test'

const hre = require("hardhat");
const { ethers } = hre;
const { use, expect } = require("chai");
const { solidity } = require("ethereum-waffle");

use(solidity);

describe("NestToken 🤖", function () {
    let nestToken;
    let owner;

    beforeEach(async function () {
        // create the smart contract object to test from
        [owner] = await ethers.getSigners();
        const NestToken = await ethers.getContractFactory("NestToken");
        nestToken = await NestToken.deploy();
    });

    describe("Deployment", function () {
        it("Should set the right owner", async function () {
            expect(await nestToken.owner()).to.equal(owner.address);
        });

        it("should total supply equal zero", async () => {
            expect(await nestToken.totalSupply()).to.equal(0);
        })
    })
    


});