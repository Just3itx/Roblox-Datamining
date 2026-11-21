-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:19:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
return {
    ContactImporterManager = require(script.ContactImporterManager),
    Actions = require(script.Actions),
    ContactsList = require(script.ContactsList.Components.ContactsList),
    ContactsRevokedAccessDialog = require(script.ContactsList.Components.ContactsRevokedAccessDialog),
    installReducer = require(script.installReducer),
    ShowContactImporterParams = require(script.installReducer.ShowContactImporterParams),
    FindFriendsModal = require(script.FindFriendsModal),
    ContactImporterLandingPage = require(script.ContactImporterLandingPage),
    Networking = require(script.Networking),
    Signals = require(script.Signals),
    RoduxKey = require(script.Common.Constants).RODUX_KEY,
    Constants = require(script.Common.Constants),
    TextKeys = require(script.Common.TextKeys),
    Utils = require(script.Utils),
    Flags = require(script.Flags),
    dependencies = require(script.dependencies),
    useBeginContactImporter = require(script.Hooks.useBeginContactImporter),
    ["jest.config"] = script["jest.config"]
}
