function PesterMatchHashtable($value, $expectedMatch) {
    # Write-Host "foo: $(ConvertTo-Json $value); $(ConvertTo-Json $expectedMatch)"
    if($value.Count -ne $expectedMatch.Count){
        return $false;
    }
    foreach($expectedKey in $expectedMatch.Keys) {
        if (-not($value.Keys -contains $expectedKey)){
            return $false;
        }
        if (-not ($value[$expectedKey] -eq $expectedMatch[$expectedKey])){
            return $false;
        }
    }
    return $true;
}

function PesterMatchHashtableFailureMessage($value, $expectedMatch) {
    foreach($expectedKey in $expectedMatch.Keys) {
        if (-not($value.Keys -contains $expectedKey)){
            return "Expected key: {$expectedKey}, but missing in actual"
        }
        $expectedValue = $expectedMatch[$expectedKey]
        $actualValue = $value[$expectedKey]
        if (-not ($actualValue -eq $expectedValue)) {
            return "Value differs for key {$expectedKey}. Expected value: {$expectedValue}, actual value: {$actualValue}"
        }
    }

    foreach($actualKey in $value.Keys) {
        if (-not($expectedMatch.Keys -contains $actualKey)){
            return "Actual key: {$actualKey}, but missing in expected"
        }
        $expectedValue = $expectedMatch[$actualKey]
        $actualValue = $value[$actualKey]
        if (-not ($actualValue -eq $expectedValue)) {
            return "Value differs for key {$actualKey}. Expected value: {$expectedValue}, actual value: {$actualValue}"
        }
    }
    # for($i=0; $i -lt $expectedMatch.Keys.Length; $i++){
    #     $expectedKey = $expectedMatch.Keys[$_]
    #     if($value.Keys -contains $expectedKey){
    #         $expectedValue = $expectedMatch[$expectedKey]
    #         $actualValue = $value[$expectedKey]
    #         if (-not ($actualValue -eq $expectedValue)) {
    #             return "Value differs for key {$expectedKey}. Expected value: {$expectedValue}, actual value: {$actualValue}"
    #         }
    #     } else {
    #         return "Expected key: {$expectedMatch}, but missing in actual"
    #     }
    # }
    # for($i=0; $i -lt $value.Keys.Length; $i++){
    #     $actualKey = $value.Keys[$_]
    #     if($expectedMatch.Keys -contains $actualKey){
    #         $expectedValue = $expectedMatch[$actualKey]
    #         $actualValue = $value[$actualKey]
    #         if (-not ($actualValue -eq $expectedValue)) {
    #             return "Value differs for key {$actualKey}. Expected value: {$expectedValue}, actual value: {$actualValue}"
    #         }
    #     } else {
    #         return "Actual contains key: {$actualKey}, but not expected"
    #     }
    # }
}

function NotPesterMatchHashtableFailureMessage($value, $expectedMatch) {
    return "Expected: ${value} to not match the expression ${expectedMatch}"
}
