import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Debug "mo:base/Debug";

actor Token {
  var owner : Principal = Principal.fromText("t3awl-qepnk-7wxvw-xqv7s-wltvf-phedk-z3gjt-jenng-4e3vr-b6zh4-tae");
  var totalSupply : Nat = 1000000000;
  var symbol : Text = "DECC";
  
  var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);
  
  // FIX 1: Motoko requires you to write "ignore" when a function returns a value that you don't save to a variable.
  ignore balances.put(owner, totalSupply);

  public query func balanceOf(who : Principal) : async Nat {
    let balance : Nat = switch (balances.get(who)) {
      case null 0;
      case (?result) result;
    };
    return balance;
  };

  public query func getSymbol() : async Text {
    return symbol;
  };

  // FIX 2: Changed 'async ()' to 'async Text' because you are returning text ("success" and "Already claimed")
  public shared(msg) func payOut() : async Text {

    Debug.print(debug_show(msg.caller));

    // FIX 3: You used the word 'amount' below, but never created the variable! I added it here.
    let amount : Nat = 10000;

    if (balances.get(msg.caller) == null) {
      ignore balances.put(msg.caller, amount); // Added 'ignore' here too
      return "success";
    } 
    else {
      return "Already claimed";
    }

  };
  
  // FIX 4: Functions that use 'await' must be labeled as 'async'. 
  public shared func transfer(to: principal, amount:Nat) : async Text {
    
    let fromBalance = await balanceOf(msg.caller);
    if (fromBalance >= amount) {
      let newFromBalance = fromBalance - amount;
      ignore balances.put(msg.caller, newFromBalance); // Added 'ignore' here too   
      let toBalance = await balanceOf(to);
      let newToBalance = toBalance + amount;
      ignore balances.put(to, newToBalance); // Added 'ignore' here too 
      
      return "success";
    } else {
      return "Insufficient balance";
    }
  }
};