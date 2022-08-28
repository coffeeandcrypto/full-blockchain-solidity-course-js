//this is functionally the same as the one below
// describe("Simple Storage", () => {})

const { ethers, run, network } = require("hardhat")
const { expect, assert } = require("chai")

describe("SimpleStorage", function () {
    // declare our variables outside the beforeeach and set them equal to nothing
    let SimpleStorageFactory, simpleStorage

    //beforeEach test, deploy the contract so we have something to test
    beforeEach(async function () {
        SimpleStorageFactory = await ethers.getContractFactory("SimpleStorage")

        simpleStorage = await SimpleStorageFactory.deploy()
    })

    it("Should start with a favorite number of 0", async function () {
        const currentValue = await simpleStorage.retrieve()
        const expectedValue = "0"
        assert.equal(currentValue.toString(), expectedValue)
        // expect(currentValue.toString()).to.equal(expectedValue) is the same as the above
    })

    //if we make the test say it.only, the test command will only run that test
    //if we run the command yarn hardhat test --grep store (in this case) it will only run the test with the word store in it
    it("Should update when we call store", async function () {
        const expectedValue = "7"
        const transactionResponse = await simpleStorage.store(expectedValue)
        await transactionResponse.wait(1)

        const currentValue = await simpleStorage.retrieve()
        assert.equal(currentValue.toString(), expectedValue)
    })
})
