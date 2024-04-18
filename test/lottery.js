const Lottery = artifacts.require("Lottery");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("Lottery", function ( accounts ) {
  it("should assert true", async function () {
    await Lottery.deployed();
    return assert.isTrue(true);
  });
 
  it("should allow multiple accounts to enroll", async () => {
    const lottery = await Lottery.deployed();
    const wager = web3.utils.toWei('1', 'ether');
    const expectedPricePool = web3.utils.toWei('9', 'ether');
    const expectedJackPot = web3.utils.toWei('0.9', 'ether');

    for(let i = 0; i < 10; i++) {
      await lottery.enroleInLottery({from: accounts[i], value: wager});  
    }  

  const playersCount = await lottery.getParticipants();
  const pricePool = await lottery.getPricePool();
  const jackPot = await lottery.getJackPot();

  assert.equal(playersCount.length, 10, "There should be exactly 10 players");
  assert.equal(expectedPricePool, pricePool, "The pricePool should be 9");
  assert.equal(expectedJackPot, jackPot, "The jackpot should be 0.9");
   
  });

  /*it("should allow multiple accounts to enroll", async () => {
    const lottery = await Lottery.deployed();
    const wager = web3.utils.toWei('1', 'ether');
    const expectedPricePool = web3.utils.toWei('9', 'ether');

    for(let i = 0; i < 10; i++) {
      await lottery.enroleInLottery({from: accounts[i], value: wager});  
    }
  

  const playersCount = await lottery.getParticipants();
  const pricePool = await lottery.getPricePool();
  assert.equal(playersCount.length, 10, "There should be exactly 10 players");
  assert.equal(expectedPricePool, pricePool);
   
  });*/
//})
});
