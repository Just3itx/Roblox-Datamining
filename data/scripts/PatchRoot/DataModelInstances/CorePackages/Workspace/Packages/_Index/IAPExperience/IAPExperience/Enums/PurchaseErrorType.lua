-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local addRawValueMethodToEnum = require(scriptParentParent.Utility.addRawValueMethodToEnum)

local tbl1 = {
    None = "None",
    Unknown = "Unknown",
    AlreadyOwn = "AlreadyOwn",
    FailedGrant = "FailedGrant",
    FailedGrantUnknown = "FailedGrantUnknown",
    Limited = "Limited",
    NotEnoughRobux = "NotEnoughRobux",
    NotEnoughRobuxInApp = "NotEnoughRobuxInApp",
    NotForSale = "NotForSale",
    NotForSaleExperience = "NotForSaleExperience",
    PremiumOnly = "PremiumOnly",
    ThirdPartyDisabled = "ThirdPartyDisabled",
    Under13 = "Under13",
    PremiumPlatformUnavailable = "PremiumPlatformUnavailable",
    AlreadyPremium = "AlreadyPremium",
    PurchaseLimit = "PurchaseLimit",
    ParentalLimit = "ParentalLimit",
    AlreadySubscribed = "AlreadySubscribed",
    SubscriptionNotForSale = "SubscriptionNotForSale",
    SubscriptionExceededUserSpendLimit = "SubscriptionExceededUserSpendLimit",
    SubscriptionUnsupportedLocale = "SubscriptionUnsupportedLocale",
    RestrictedUser = "RestrictedUser",
    SubscriptionPurchasePlatformNotSupported = "SubscriptionPurchasePlatformNotSupported",
    SubscriptionInvalidSaleLocation = "SubscriptionInvalidSaleLocation",
    VpcRequired = "VpcRequired",
    FailedRobuxPurchase = "FailedRobuxPurchase",
    ExceedParentalSpendLimit = "ExceedParentalSpendLimit",
    EconomicRestriction = "EconomicRestriction"
}
local var1 = require(scriptParentParentParent.enumerate)(script.Name, tbl1)

addRawValueMethodToEnum(var1, tbl1)

return var1
