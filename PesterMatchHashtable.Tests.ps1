﻿$here = Split-Path -Parent $MyInvocation.MyCommand.Path
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
        Test-PositiveAssertion (PesterMatchHashtable @{"a"=1} @{"a"=1})
    }
    It "returns true for hashtable with the same contents" {
        Test-PositiveAssertion (PesterMatchHashtable @{"a"=1; "b"="test"} @{"a"=1; "b"="test"})
    }
    It "returns true for hashtable with the same contents in different orders" {
        Test-PositiveAssertion (PesterMatchHashtable @{"a"=1; "b"="test"} @{"b"="test";"a"=1})
    }

    It "returns false if hashtable differ in content" {
        Test-NegativeAssertion (PesterMatchHashtable @{"a"=1; "b"="test"} @{"a"=1; "b"="different value"})
    }
    It "returns false if hashtable differ in length - input2 longer" {
        Test-NegativeAssertion (PesterMatchHashtable @{"a"=1} @{"a"=1; "b"="test"})
    }
    It "returns false if hashtable differ in length - input1 longer" {
        Test-NegativeAssertion (PesterMatchHashtable @{"a"=1; "b"="test"} @{"a"=1})
    }
}
