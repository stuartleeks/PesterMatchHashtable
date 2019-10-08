$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"


## Test Assertion functions takenb from: https://github.com/pester/Pester/blob/ebfb0997365fea29f25b2aa3065378a3765eff4c/Functions/Assertions/Test-Assertion.ps1
function Test-PositiveAssertion($result) {
    if (-not $result) {
        throw "Expecting expression to pass, but it failed"
    }
}

function Test-NegativeAssertion($result) {
    if ($result) {
        throw "Expecting expression to pass, but it failed"
    }
}

Describe "PesterMatchHashtable" {
    It "returns true for matching single item hashtable with same values" {
        @{"a" = 1} | Should MatchHashtable @{"a" = 1}
    }
    It "returns true for hashtable with the same contents" {
        @{"a" = 1; "b" = "test"} | Should MatchHashtable  @{"a" = 1; "b" = "test"}
    }
    It "returns true for hashtable with the same contents in different orders" {
        @{"a" = 1; "b" = "test"} | Should MatchHashtable  @{"b" = "test"; "a" = 1}
    }
    It "return true for matching multi-level hash table" {
        @{"a" = 1; "multi-level" = @{"b" = "test"}}  | Should MatchHashtable  @{"a" = 1; "multi-level" = @{"b" = "test"}}
    }

    It "returns false if hashtable differ in content" {
        @{"a" = 1; "b" = "test"}  | Should Not MatchHashtable @{"a" = 1; "b" = "different value"}
    }
    It "returns false if hashtable differ in length - input2 longer" {
        @{"a" = 1} | Should Not MatchHashtable  @{"a" = 1; "b" = "test"}
    }
    It "returns false if hashtable differ in length - input1 longer" {
        @{"a" = 1; "b" = "test"}  | Should Not MatchHashtable  @{"a" = 1}
    }
    It "return false if matching multi-level hash table differ in content" {
        @{"a" = 1; "multi-level" = @{"b" = "test"}}  | Should Not MatchHashtable  @{"a" = 1; "multi-level" = @{"b" = "different value"}}
    }
}
