#include <PCGGram/Ruleset.hpp>

#include <iostream>

using namespace PCGGrammar;


// Ruleset class = = = = = = =

Ruleset::Ruleset() { }


Ruleset::~Ruleset() { }


__RuleInjector* Ruleset::Rule(string sym) {
    __RuleInjector* work = new __RuleInjector(this, sym);
    return work;
}


void Ruleset::AddRule(string rule, ComponentVector components, float weight) {
    mRules.insert( pair<string, ComponentVector>(rule, components) );
    mRuleWeights.insert( pair<string, float>(rule, weight) );
}


bool Ruleset::IsTerminal(string sym) const {
    if(mRules.find(sym) != mRules.end())
        return false;
    else
        return true;
}


vector<string> Ruleset::GetNonTerminals(void) const {
    vector<string> res;

    // Instead of it++ increment to the next unique key with upper_bound
    for(RuleMap::const_iterator it = mRules.begin(); it!=mRules.end(); it=mRules.upper_bound(it->first))
        res.push_back(it->first);

    return res;
}


pair< RuleMap::const_iterator, RuleMap::const_iterator > Ruleset::GetRulesFor(string sym) const {
    return mRules.equal_range(sym);
}


pair< DistributionMap::const_iterator, DistributionMap::const_iterator > Ruleset::GetWeightsFor(string sym) const {
    return mRuleWeights.equal_range(sym);
}


// __RuleInjector class = = = = = = =

__RuleInjector::__RuleInjector(Ruleset* parentObject, string parentRule) {
    mpParent = parentObject;
    mParentRule = parentRule;
    mRule.clear();
}


__RuleInjector* __RuleInjector::Sym(string sym) {
    mRule.push_back(sym);
    return this;
}


void __RuleInjector::End() {
    End(1.0f);
}


void __RuleInjector::End(float weight) {
    mpParent->AddRule(mParentRule, mRule, weight);
    delete this;
}

