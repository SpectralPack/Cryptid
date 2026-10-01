# Contributing

## How to Contribute

1. **Propose your idea** in Cryptid Discord
2. **Get feedback** from community and maintainers
3. **Implement** your content following guidelines
4. **Test thoroughly** across gamesets
5. **Submit pull request** with proper documentation

## Where to Contribute

### Discord Channels

**All issues, suggestions, and help requests go through Discord, not GitHub Issues.**

- **#suggestions** - Propose new content (jokers, decks, etc.)
- **#bug-reports** - Report bugs and crashes
- **#help** - Get help with the mod or development
- **#development** - Discuss code and contributions

### GitHub

- **Pull Requests** - Submit implemented features
- **Wiki** - Documentation improvements
- **Discussions** - General discussion (optional, Discord preferred)

## Contribution Guidelines

### We Accept

**New Content**:

- Jokers (Common, Uncommon, Rare, Epic, Exotic)
- Consumables (Tarot, Planet, Spectral, Code)
- Decks
- Blinds
- Challenges
- Stakes
- Vouchers
- Achievements
- Tags
- Editions, Enhancements, Seals, Stickers

**Improvements**:

- Bug fixes
- Performance optimizations
- Documentation updates
- Localization additions
- Cross-mod compatibility

**Systems**:

- New mechanics (with discussion)
- Helper functions
- UI improvements

### We DON'T Accept

- **Breaking Changes** - Without prior discussion  
- **Undocumented Code** - Must have comments  
- **Untested Content** - Must test in all gamesets  
- **Low Effort** - Lazy recolors, joke submissions  
- **Conflicting Content** - Duplicates existing items  

## Content Proposal Templates

When proposing new content in Discord, use these templates:

### Joker Proposal Template

```markdown
**Name**: Economic Inflation

**Rarity**: Cursed (cry_cursed)

**Effect**: 
- Rental cards cost +$1 more
- This joker gains +$1 cost at end of round
- Costs (1 × current Rental price) to sell
- Either spawns as Rental OR applies Rental to another joker when obtained

**Stats**:
- Buy Cost: Irrelevant (Cursed rarity)
- Sell Price: -(1 × Rental sticker costs)
- Blueprint Compatible: No
- Eternal Compatible: No
- Perishable Compatible: No

**Gameset Differences**:
- Modest: [if different]
- Mainline: Standard
- Madness: [if different]

**Unlock Condition**: [How to unlock, if any]

**Credits**:
- Idea: Your Name
- Art: Artist Name (or "Needed")
- Code: Coder Name (or "Needed")

**Notes**: [Any special interactions or concerns]
```

### Deck Proposal Template

```markdown
**Name**: My Deck

**Effect**: 
- [Main mechanic]
- [Secondary effects]

**Stats**:
- Starting Hands: [modifier]
- Starting Discards: [modifier]
- Starting Money: [modifier]
- Hand Size: [modifier]
- Joker Slots: [modifier]
- Other modifiers: [list]

**Unlock Condition**: [How to unlock]

**Gameset Differences**:
- Modest: [if different]
- Mainline: Standard
- Madness: [if different]

**Credits**:
- Idea: Your Name
- Art: Artist Name (or "Needed")
- Code: Coder Name (or "Needed")
```

### Consumable Proposal Template

```markdown
**Name**: My Card

**Type**: Tarot / Planet / Spectral / Code

**Effect**: [What it does]

**Cost**: $X

**Restrictions**: [Can only be used when...]

**Special Properties**:
- Multi-use: [if applicable]
- Soul Card: [if hidden/rare]
- Conditional Pool: [if limited appearance]

**Unlock Condition**: [if any]

**Credits**:
- Idea: Your Name
- Art: Artist Name (or "Needed")
- Code: Coder Name (or "Needed")
```

### Blind Proposal Template

```markdown
**Name**: The [Name]

**Type**: Boss / Showdown

**Effect**: [What it does to the player]

**Stats**:
- Ante Range: X-Y
- Chip Multiplier: [if different from 2]
- Reward: [if different from $5]

**Counters**: [Jokers/strategies that counter it]

**Credits**:
- Idea: Your Name
- Art: Artist Name (or "Needed")
```

### Challenge Proposal Template

```markdown
**Name**: My Challenge

**Rules**:
- [Custom rule 1]
- [Custom rule 2]

**Modifiers**:
- Joker Slots: X
- Hands: X
- Discards: X
- [Other modifiers]

**Starting Items**:
- Jokers: [list with editions/stickers]
- Consumables: [list]
- Vouchers: [list]

**Restrictions**:
- Banned Jokers: [list]
- Banned Consumables: [list]
- Banned Other: [list]

**Deck**: Standard / Custom [describe if custom]

**Credits**:
- Idea: Your Name
```

### Stake Proposal Template

```markdown
**Name**: [Color] Stake

**Position**: After [Previous Stake] (Stake X)

**Effect**: [Difficulty modifier]

**Modifiers**:
- [List all G.GAME.modifiers set]

**Progression**: Builds on all previous stakes

**Credits**:
- Idea: Your Name
```

### Voucher Proposal Template

```markdown
**Name**: My Voucher

**Tier**: 1 / 2 / 3

**Requires**: [Tier 1 voucher] (if Tier 2/3)

**Effect**: [What it does]

**Cost**: $X

**Conditional Pool**: [if only appears under certain conditions]

**Credits**:
- Idea: Your Name
- Art: Artist Name (or "Needed")
- Code: Coder Name (or "Needed")
```

### Tag Proposal Template

```markdown
**Name**: [Name] Tag

**Type**: Skip reward / New blind / Store joker / etc.

**Effect**: [What it does]

**Trigger**: When does it apply

**Credits**:
- Idea: Your Name
- Art: Artist Name (or "Needed")
```

### Achievement Proposal Template

```markdown
**Name**: Achievement Name

**Type**: Normal / Platinum

**Unlock Condition**: [Specific condition to meet]

**Hidden**: Yes / No

**Credits**:
- Idea: Your Name
```

### Edition/Enhancement/Seal/Sticker Template

```markdown
**Name**: My [Type]

**Type**: Edition / Enhancement / Seal / Sticker

**Visual**: [Description or reference image]

**Effect**: [What it does]

**Availability**: 
- Shop weight: [if edition]
- Application rate: [if sticker]

**Shader**: [if edition - describe visual effect]

**Credits**:
- Idea: Your Name
- Art: Artist Name (or "Needed")
- Shader: Shader Author (or "Needed" if edition)
```

## Pull Request Structure

### PR Title Format

```markdown
[TYPE] Brief Description

Examples:
[JOKER] Add Economic Inflation
[DECK] Add Paradox Deck
[SPECTRAL] Add Metamorphosis
[BUGFIX] Fix Dropshot suit tracking
[DOCS] Update joker tutorial
```

### PR Description Template

```markdown
## Description

Brief explanation of what this PR does.

## Type of Change

- [ ] New Content (joker, deck, consumable, etc.)
- [ ] Bug Fix
- [ ] Documentation
- [ ] Refactor/Optimization
- [ ] Other: [describe]

## Content Details

**Name**: [Content name]

**Type**: [Joker/Deck/etc.]

**Files Changed**:
- `items/[file].lua` - [what changed]
- `localization/en-us.lua` - [added descriptions]
- `assets/[atlas].png` - [added sprites if applicable]

## Implementation

### Key Features

- Feature 1
- Feature 2
- Feature 3

### Gameset Behavior

- **Modest**: [behavior]
- **Mainline**: [behavior]
- **Madness**: [behavior]

### Dependencies

- Depends on: [list content sets or items]
- Conflicts with: [if any]

## Testing

- [x] Tested in Modest gameset
- [x] Tested in Mainline gameset
- [x] Tested in Madness gameset
- [x] Tested with Blueprint (if applicable)
- [x] Tested with other copying effects
- [x] Tested edge cases
- [x] No crashes or errors
- [x] Localization complete (EN-US minimum)

## Screenshots/Video

[Optional: Add screenshots or video demonstration]

## Unlock Condition

[If applicable: How to unlock this content]

## Credits

- **Idea**: [Name(s)]
- **Art**: [Name(s)]
- **Code**: [Name(s)]
- **Testing**: [Name(s)]

## Additional Notes

[Any special considerations, known issues, or future plans]

## Checklist

- [ ] Code follows project style
- [ ] Documentation added/updated
- [ ] Localization added (at least EN-US)
- [ ] Tested thoroughly
- [ ] No console errors
- [ ] Sprite added (if needed)
- [ ] Referenced in relevant tutorials (if new pattern)
```

## Code Standards

### Naming Conventions

- **Keys**: lowercase, underscores (e.g., `"my_joker"`)
- **Names**: prefix with `"cry-"` (e.g., `"cry-My Joker"`)
- **Variables**: descriptive names, not `a`, `b`, `c`
- **Functions**: `snake_case` for locals, `camelCase` for methods

### Localization

Always include English localization:

```lua
descriptions = {
    Joker = {
        j_cry_my_joker = {
            name = "My Joker",
            text = {
                "Does something cool",
                "with {C:attention}#1#{} value"
            },
            unlock = {
                "Unlock condition",
                "description"
            }
        }
    }
}
```

## Credits

Always give proper credit 🙏

- **Idea**: YourName
- **Art**: ArtistName
- **Code**: CoderName

## Getting Help

### Discord Support

- **#i-need-help** - Questions about contributing
- **#cryptid-dev** - Technical discussions
- **#cryptid-dev** - Card art discussions
- **#suggestion-discussion** - Feedback on ideas
- **#bug-report** - Forum where bugs are reported (basically an issues section)

### Documentation

- **ldocs/** folder - Tutorials for each content type
- **API_DOCUMENTATION.md** - Complete API reference
- **NAMING_CONVENTIONS.md** - Prefix and naming guide
- **Source code** - All item files are documented

### Example Content

Study existing implementations:
- **Simple joker**: Look at items/misc_joker.lua
- **Complex joker**: Look at items/epic.lua
- **Deck with modifiers**: Look at items/deck.lua
- **Multi-effect consumable**: Look at items/spectral.lua

## Localization Contributions

### Adding Translations

1. Copy `localization/en-us.lua`
2. Rename to your language code (e.g., `es_ES.lua`)
3. Translate all strings
4. Test in-game with language setting
5. Submit PR with translation

### Translation Guidelines

- Keep formatting codes: `{C:mult}`, `{X:mult,C:white}`, `#1#`
- Maintain line breaks for readability
- Test that variables `#1#`, `#2#` etc. make sense
- Consider family mode variants if applicable

## Style Guide Quick Reference

### **DO**

- Use descriptive variable names
- Add comments explaining complex logic
- Follow existing patterns in the codebase
- Test in all gamesets
- Document your functions
- Include unlock handlers
- Credit all contributors

### **DON'T**

- Use single-letter variables (except loops)
- Leave debug prints in code
- Hardcode values that should be configurable
- Forget `cry_lock_all`/`cry_unlock_all` handlers
- Skip documentation
- Submit without testing
- Copy code without understanding it

## Questions?

**Join the Cryptid Discord**: [https://discord.gg/eUf9Ur6RyB](https://discord.gg/eUf9Ur6RyB)
