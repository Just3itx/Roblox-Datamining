-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local enumerate = require(PurchasePromptParent.PurchasePromptDeps).enumerate

local addRawValueMethodToEnum = require(PurchasePrompt.Utils.addRawValueMethodToEnum)

local tbl1 = { None = "None", EnablePurchase = "EnablePurchase" }

local var1 = enumerate(script.Name, tbl1)

addRawValueMethodToEnum(var1, tbl1)

return var1
