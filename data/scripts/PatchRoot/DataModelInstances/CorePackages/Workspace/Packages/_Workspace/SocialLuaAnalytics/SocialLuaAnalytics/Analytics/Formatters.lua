-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    formatRecommendationContextType = require(script.formatRecommendationContextType),
    formatPresence = require(script.formatPresence),
    createDiagMetricString = require(script.createDiagMetricString),
    repeatValue = function(num1: number, num2: number): string
        return table.concat(table.create(num2, tostring(num1)), ",")
    end
}
