import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";

actor Token {
  var owner : Principal = Principal.fromText("t3awl-qepnk-7wxvw-xqv7s-wltvf-phedk-z3gjt-jenng-4e3vr-b6zh4-tae");
  var totalSupply : Nat = 1000000000;
  var symbol : Text = "DECC";
  var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);
  balances.put(owner, totalSupply);

  public query func balanceOf(who : Principal) : async Nat {

    let balance : Nat = switch (balances.get(who)) {
      case null 0;
        case (?result) result;
    };
    
      return balance;
    }
  
};