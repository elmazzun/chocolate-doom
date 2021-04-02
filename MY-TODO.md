# My TODO

List of potential additions to game:

- [ ] make Doomguy jump:
  - [x] make the game tell that "jump" key was pressed (space)
  - [x] make the Doomguy actually jump
    - [x] ignore space if held down; space must be taken for good only at the
        end of the jump
    - [ ] since space will be jump, set E as action key instead of space
    - [x] update `p_user:P_MovePlayer()`
    - [ ] it seems that Doomguy does not goes forward while jumping,
        nor it manages to jump over obstacles
- [ ] make Doomguy dash:
  - [ ] make the game tell that "dash" key was pressed
- [ ] bazooka firing at same speed of gatling;
