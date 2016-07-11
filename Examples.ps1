$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Import-Module "$here\PesterMatchHashtable.psm1" -Force

Describe "MatchHashtable examples" {
	It "single item hashtables match" {
       @{"a"=1} | Should MatchHashtable @{"a"=1}
    }
    It "hashtables  with the same contents match" {
        @{"a"=1;"b"="wibble"} | Should MatchHashtable @{"b"="wibble";"a"=1}
    }
    It "hashtables with different lengths do not match" {
        @{"a"=1} | Should Not MatchHashtable @{"b"="wibble";"a"=1}
    }
    It "hashtables with different lengths do not match" {
        @{"a"=1;"b"="wibble"} | Should Not MatchHashtable @{"b"="wibble"}
    }
    It "hashtables with different values do not match" {
        @{"a"=1;"b"="wibble"} | Should Not MatchHashtable @{"a"=123; "b"="wibble"}
    }
}
