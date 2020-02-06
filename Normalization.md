1nf:
- All attributes are atomic

2nf:
- 1nf
- No Partial Dependencies:
    - If {A1,A2} is a candidate key and {A2} → A4 then this is a partial dependency, because A4 can be found without candidate key {A1,A2}, but is dependant on a superset of {A1,A2}

3nf:
- 2nf
- No transitve dependency: 
    - If {A1} → A3, then we cannot have {A3} → A4 as well, because this implies {A1} → A4
3.5nf:
- 3nf
- For any dependency {A} → B, {A} should be a super key.