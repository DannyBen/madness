Change Log
========================================

v0.9.7 - 2022-09-09
----------------------------------------

- Remove Rack:SSL
- Exit gracefully from exceptions
- Remove search icon from print view
- Add support for [[Short Links]]


v0.9.6 - 2022-07-01
----------------------------------------

- Drop support for Ruby 2.5
- Pass file path to the document template


v0.9.5 - 2022-01-21
----------------------------------------

- Add search button in mobile view


v0.9.4 - 2021-09-16
----------------------------------------

- Add configuration to control excluded directories list


v0.9.3 - 2021-02-05
----------------------------------------

- Allow showing non-md files in the navigation


v0.9.2 - 2021-01-13
----------------------------------------

- Improve search so that it is an OR search by default, and allows quoted phrases for exact match


v0.9.1 - 2021-01-04
----------------------------------------

- CSS: Remove outline on focused links


v0.9.0 - 2020-12-31
----------------------------------------

- Remove ferret and implement simpler search


v0.8.6 - 2020-12-26
----------------------------------------

- Remove deprecated SASS and use plain CSS


v0.8.5 - 2020-12-03
----------------------------------------

- Update puma to 5.1


v0.8.4 - 2020-11-08
----------------------------------------

- Update to puma 5.x
- Add optional in-document Table of Contents
- Revert puma upgrade back to < 5.0 due to puma bugs


## [v0.8.3](https://github.com/DannyBen/madness/tree/v0.8.3) (2020-05-06)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.8.2...v0.8.3)

**Merged pull requests:**

- Fixes for Ruby 2.7 [\#97](https://github.com/DannyBen/madness/pull/97) ([DannyBen](https://github.com/DannyBen))

## [v0.8.2](https://github.com/DannyBen/madness/tree/v0.8.2) (2020-04-27)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.8.1...v0.8.2)

**Merged pull requests:**

- Updates [\#96](https://github.com/DannyBen/madness/pull/96) ([DannyBen](https://github.com/DannyBen))

## [v0.8.1](https://github.com/DannyBen/madness/tree/v0.8.1) (2020-04-26)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.8.0...v0.8.1)

**Implemented enhancements:**

- Consider re-adding GraphViz / UML support [\#41](https://github.com/DannyBen/madness/issues/41)

**Merged pull requests:**

- Add configurable search limit [\#95](https://github.com/DannyBen/madness/pull/95) ([DannyBen](https://github.com/DannyBen))
- Switch to github actions [\#94](https://github.com/DannyBen/madness/pull/94) ([DannyBen](https://github.com/DannyBen))

## [v0.8.0](https://github.com/DannyBen/madness/tree/v0.8.0) (2019-12-29)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.7.6...v0.8.0)

**Merged pull requests:**

- Fix redirect in paths with spaces and add 404 [\#93](https://github.com/DannyBen/madness/pull/93) ([DannyBen](https://github.com/DannyBen))
- Fix ffi-related failing tests [\#92](https://github.com/DannyBen/madness/pull/92) ([DannyBen](https://github.com/DannyBen))

## [v0.7.6](https://github.com/DannyBen/madness/tree/v0.7.6) (2019-12-08)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.7.5...v0.7.6)

**Implemented enhancements:**

- Add ability to "Copy" code [\#89](https://github.com/DannyBen/madness/issues/89)
- Add flag to start/stop in the background [\#5](https://github.com/DannyBen/madness/issues/5)

**Merged pull requests:**

- Test with Ruby 2.7 [\#91](https://github.com/DannyBen/madness/pull/91) ([DannyBen](https://github.com/DannyBen))

## [v0.7.5](https://github.com/DannyBen/madness/tree/v0.7.5) (2019-12-05)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.7.4...v0.7.5)

**Merged pull requests:**

- Copy to clipboard [\#90](https://github.com/DannyBen/madness/pull/90) ([DannyBen](https://github.com/DannyBen))

## [v0.7.4](https://github.com/DannyBen/madness/tree/v0.7.4) (2019-11-16)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.7.3...v0.7.4)

**Implemented enhancements:**

- feature: optionally start a browser when executing madness [\#84](https://github.com/DannyBen/madness/issues/84)

**Merged pull requests:**

- Add --open flag to launch browser [\#88](https://github.com/DannyBen/madness/pull/88) ([DannyBen](https://github.com/DannyBen))
- Extended PR 85 [\#86](https://github.com/DannyBen/madness/pull/86) ([DannyBen](https://github.com/DannyBen))

## [v0.7.3](https://github.com/DannyBen/madness/tree/v0.7.3) (2019-10-26)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.7.2...v0.7.3)

**Merged pull requests:**

- Upgrade some dependencies [\#83](https://github.com/DannyBen/madness/pull/83) ([DannyBen](https://github.com/DannyBen))
- Maintenance update [\#82](https://github.com/DannyBen/madness/pull/82) ([DannyBen](https://github.com/DannyBen))

## [v0.7.2](https://github.com/DannyBen/madness/tree/v0.7.2) (2019-01-04)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.7.1...v0.7.2)

**Merged pull requests:**

- Update sinatra to 2.0.5 [\#81](https://github.com/DannyBen/madness/pull/81) ([DannyBen](https://github.com/DannyBen))

## [v0.7.1](https://github.com/DannyBen/madness/tree/v0.7.1) (2018-12-13)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.7.0...v0.7.1)

**Merged pull requests:**

- Bundle update [\#80](https://github.com/DannyBen/madness/pull/80) ([DannyBen](https://github.com/DannyBen))

## [v0.7.0](https://github.com/DannyBen/madness/tree/v0.7.0) (2018-11-14)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.6.9...v0.7.0)

**Merged pull requests:**

- Add option to force HTTPS [\#79](https://github.com/DannyBen/madness/pull/79) ([DannyBen](https://github.com/DannyBen))

## [v0.6.9](https://github.com/DannyBen/madness/tree/v0.6.9) (2018-10-20)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.6.8...v0.6.9)

**Merged pull requests:**

- Allow embedding HTML [\#78](https://github.com/DannyBen/madness/pull/78) ([DannyBen](https://github.com/DannyBen))

## [v0.6.8](https://github.com/DannyBen/madness/tree/v0.6.8) (2018-10-18)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.6.7...v0.6.8)

**Fixed bugs:**

- Fix CSS issues [\#77](https://github.com/DannyBen/madness/pull/77) ([DannyBen](https://github.com/DannyBen))

## [v0.6.7](https://github.com/DannyBen/madness/tree/v0.6.7) (2018-09-20)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.6.6...v0.6.7)

**Closed issues:**

- Body min-height belongs under .with-sidebar [\#73](https://github.com/DannyBen/madness/issues/73)

**Merged pull requests:**

- Downgrade Sinatra [\#76](https://github.com/DannyBen/madness/pull/76) ([DannyBen](https://github.com/DannyBen))
- Refactor settings to allow arbitrary user input [\#75](https://github.com/DannyBen/madness/pull/75) ([DannyBen](https://github.com/DannyBen))

## [v0.6.6](https://github.com/DannyBen/madness/tree/v0.6.6) (2018-08-21)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.6.5...v0.6.6)

**Merged pull requests:**

- Fix layout to have HTML tag [\#72](https://github.com/DannyBen/madness/pull/72) ([DannyBen](https://github.com/DannyBen))

## [v0.6.5](https://github.com/DannyBen/madness/tree/v0.6.5) (2018-08-11)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.6.4...v0.6.5)

**Closed issues:**

- Search result file labels should omit README [\#70](https://github.com/DannyBen/madness/issues/70)

**Merged pull requests:**

- Search improvements [\#71](https://github.com/DannyBen/madness/pull/71) ([DannyBen](https://github.com/DannyBen))

## [v0.6.4](https://github.com/DannyBen/madness/tree/v0.6.4) (2018-08-10)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.6.3...v0.6.4)

**Merged pull requests:**

- Fix autocomplete [\#69](https://github.com/DannyBen/madness/pull/69) ([DannyBen](https://github.com/DannyBen))

## [v0.6.3](https://github.com/DannyBen/madness/tree/v0.6.3) (2018-08-10)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.6.2...v0.6.3)

**Implemented enhancements:**

- Add search autocomplete [\#64](https://github.com/DannyBen/madness/issues/64)

**Merged pull requests:**

- Add autocomplete [\#68](https://github.com/DannyBen/madness/pull/68) ([DannyBen](https://github.com/DannyBen))

## [v0.6.2](https://github.com/DannyBen/madness/tree/v0.6.2) (2018-08-08)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.6.1...v0.6.2)

**Closed issues:**

- Allow accessing markdown files using .md extension in the URL [\#65](https://github.com/DannyBen/madness/issues/65)

**Merged pull requests:**

- Improve test stability for theme CLI command [\#67](https://github.com/DannyBen/madness/pull/67) ([DannyBen](https://github.com/DannyBen))
- Allow request md files with or without the .md extension [\#66](https://github.com/DannyBen/madness/pull/66) ([fpenapita](https://github.com/fpenapita))
- Switch from many requires to one 'requires' [\#63](https://github.com/DannyBen/madness/pull/63) ([DannyBen](https://github.com/DannyBen))

## [v0.6.1](https://github.com/DannyBen/madness/tree/v0.6.1) (2018-06-02)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.6.0...v0.6.1)

**Merged pull requests:**

- Style improvements [\#62](https://github.com/DannyBen/madness/pull/62) ([DannyBen](https://github.com/DannyBen))

## [v0.6.0](https://github.com/DannyBen/madness/tree/v0.6.0) (2018-06-01)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.5.7...v0.6.0)

**Implemented enhancements:**

- Provide a way to define navigation order [\#59](https://github.com/DannyBen/madness/issues/59)
- Improve search style [\#57](https://github.com/DannyBen/madness/issues/57)
- Convert "Home" and "Search" links to icons [\#48](https://github.com/DannyBen/madness/issues/48)

**Closed issues:**

- Change homepage screenshot [\#56](https://github.com/DannyBen/madness/issues/56)

**Merged pull requests:**

- Add The Invisible Sorting Hand [\#61](https://github.com/DannyBen/madness/pull/61) ([DannyBen](https://github.com/DannyBen))
- Update screenshots [\#60](https://github.com/DannyBen/madness/pull/60) ([DannyBen](https://github.com/DannyBen))
- Improve search and code style [\#58](https://github.com/DannyBen/madness/pull/58) ([DannyBen](https://github.com/DannyBen))

## [v0.5.7](https://github.com/DannyBen/madness/tree/v0.5.7) (2018-05-30)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.5.6...v0.5.7)

**Implemented enhancements:**

- Look for "index.md" before we use "README.md" [\#54](https://github.com/DannyBen/madness/issues/54)

**Merged pull requests:**

- Add support for index.md instead of README.md [\#55](https://github.com/DannyBen/madness/pull/55) ([DannyBen](https://github.com/DannyBen))

## [v0.5.6](https://github.com/DannyBen/madness/tree/v0.5.6) (2018-05-30)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.5.5...v0.5.6)

**Implemented enhancements:**

- Add ability to customize theme [\#40](https://github.com/DannyBen/madness/issues/40)

**Merged pull requests:**

- Allow complete theme customization [\#53](https://github.com/DannyBen/madness/pull/53) ([DannyBen](https://github.com/DannyBen))

## [v0.5.5](https://github.com/DannyBen/madness/tree/v0.5.5) (2018-05-26)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.5.4...v0.5.5)

**Implemented enhancements:**

- Add configuration to disable appending navigation to folders [\#51](https://github.com/DannyBen/madness/issues/51)
- Add configuration to hide sidebar [\#50](https://github.com/DannyBen/madness/issues/50)

**Merged pull requests:**

- Add --no-sidebar and --no-auto-nav options [\#52](https://github.com/DannyBen/madness/pull/52) ([DannyBen](https://github.com/DannyBen))

## [v0.5.4](https://github.com/DannyBen/madness/tree/v0.5.4) (2018-05-26)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.5.3...v0.5.4)

**Implemented enhancements:**

- Add anchors to captions [\#47](https://github.com/DannyBen/madness/issues/47)

**Merged pull requests:**

- Add anchors to headers [\#49](https://github.com/DannyBen/madness/pull/49) ([DannyBen](https://github.com/DannyBen))

## [v0.5.3](https://github.com/DannyBen/madness/tree/v0.5.3) (2018-05-20)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.5.2...v0.5.3)

**Merged pull requests:**

- Bring back TryStatic from Rack::Contrib [\#46](https://github.com/DannyBen/madness/pull/46) ([DannyBen](https://github.com/DannyBen))

## [v0.5.2](https://github.com/DannyBen/madness/tree/v0.5.2) (2018-05-15)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.5.1...v0.5.2)

**Implemented enhancements:**

- Add TOC generator [\#44](https://github.com/DannyBen/madness/issues/44)
- Consider ignoring all folders that are completely lowercase [\#42](https://github.com/DannyBen/madness/issues/42)

**Merged pull requests:**

- Add TOC Generator [\#45](https://github.com/DannyBen/madness/pull/45) ([DannyBen](https://github.com/DannyBen))

## [v0.5.1](https://github.com/DannyBen/madness/tree/v0.5.1) (2018-05-12)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.5.0...v0.5.1)

**Merged pull requests:**

- Stop tampering with links [\#43](https://github.com/DannyBen/madness/pull/43) ([DannyBen](https://github.com/DannyBen))

## [v0.5.0](https://github.com/DannyBen/madness/tree/v0.5.0) (2018-05-11)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.4.2...v0.5.0)

**Merged pull requests:**

- Allow images everywhere instead of just in public [\#39](https://github.com/DannyBen/madness/pull/39) ([DannyBen](https://github.com/DannyBen))
- Change to travis.com [\#38](https://github.com/DannyBen/madness/pull/38) ([DannyBen](https://github.com/DannyBen))
- Remove shields.io and add CodeClimate coverage [\#37](https://github.com/DannyBen/madness/pull/37) ([DannyBen](https://github.com/DannyBen))
- Update rack-test requirement to ~\> 1.0 [\#36](https://github.com/DannyBen/madness/pull/36) ([dependabot-preview[bot]](https://github.com/apps/dependabot-preview))
- Fix invalid docopt example [\#34](https://github.com/DannyBen/madness/pull/34) ([DannyBen](https://github.com/DannyBen))
- Upgrade byebug to version 10.0.0 [\#33](https://github.com/DannyBen/madness/pull/33) ([depfu[bot]](https://github.com/apps/depfu))

## [v0.4.2](https://github.com/DannyBen/madness/tree/v0.4.2) (2018-02-26)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.4.1...v0.4.2)

**Merged pull requests:**

- Test against ruby 2.5 [\#32](https://github.com/DannyBen/madness/pull/32) ([DannyBen](https://github.com/DannyBen))

## [v0.4.1](https://github.com/DannyBen/madness/tree/v0.4.1) (2017-12-14)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.4.0...v0.4.1)

**Closed issues:**

- madness behind a proxy [\#24](https://github.com/DannyBen/madness/issues/24)

**Merged pull requests:**

- Bundle update and include json gem [\#31](https://github.com/DannyBen/madness/pull/31) ([DannyBen](https://github.com/DannyBen))
- Upgrade rdoc to version 6.0.0 [\#30](https://github.com/DannyBen/madness/pull/30) ([depfu[bot]](https://github.com/apps/depfu))

## [v0.4.0](https://github.com/DannyBen/madness/tree/v0.4.0) (2017-10-14)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.3.1...v0.4.0)

**Merged pull requests:**

- Switch to Sinatra 2 and drop rack-contrib [\#29](https://github.com/DannyBen/madness/pull/29) ([DannyBen](https://github.com/DannyBen))

## [v0.3.1](https://github.com/DannyBen/madness/tree/v0.3.1) (2017-04-24)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.3.0...v0.3.1)

## [v0.3.0](https://github.com/DannyBen/madness/tree/v0.3.0) (2017-04-07)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.2.1...v0.3.0)

**Implemented enhancements:**

- Add automatic rendering for GraphViz dot [\#25](https://github.com/DannyBen/madness/issues/25)

**Merged pull requests:**

- Automatic GraphViz Dot Generation [\#26](https://github.com/DannyBen/madness/pull/26) ([DannyBen](https://github.com/DannyBen))

## [v0.2.1](https://github.com/DannyBen/madness/tree/v0.2.1) (2017-03-15)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.2.0...v0.2.1)

**Merged pull requests:**

- Fix tests [\#23](https://github.com/DannyBen/madness/pull/23) ([DannyBen](https://github.com/DannyBen))
- Cosmetics [\#22](https://github.com/DannyBen/madness/pull/22) ([DannyBen](https://github.com/DannyBen))

## [v0.2.0](https://github.com/DannyBen/madness/tree/v0.2.0) (2016-07-27)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.1.1...v0.2.0)

**Merged pull requests:**

- Add ability to --index --and-quit [\#21](https://github.com/DannyBen/madness/pull/21) ([DannyBen](https://github.com/DannyBen))

## [v0.1.1](https://github.com/DannyBen/madness/tree/v0.1.1) (2016-06-26)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.1.0...v0.1.1)

## [v0.1.0](https://github.com/DannyBen/madness/tree/v0.1.0) (2016-06-23)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.0.8...v0.1.0)

**Implemented enhancements:**

- Search [\#8](https://github.com/DannyBen/madness/issues/8)

**Closed issues:**

- Add style for print [\#18](https://github.com/DannyBen/madness/issues/18)
- Verify style is reasonable on IE / EDGE [\#17](https://github.com/DannyBen/madness/issues/17)
- Verify style is reasonable on Firefox [\#16](https://github.com/DannyBen/madness/issues/16)
- HTML-Sanitize search excerpts [\#14](https://github.com/DannyBen/madness/issues/14)

**Merged pull requests:**

- Fix styles for IE, FF and Edge [\#20](https://github.com/DannyBen/madness/pull/20) ([DannyBen](https://github.com/DannyBen))
- improve search results and print style [\#19](https://github.com/DannyBen/madness/pull/19) ([DannyBen](https://github.com/DannyBen))

## [v0.0.8](https://github.com/DannyBen/madness/tree/v0.0.8) (2016-06-14)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.0.7...v0.0.8)

**Merged pull requests:**

- Add search [\#13](https://github.com/DannyBen/madness/pull/13) ([DannyBen](https://github.com/DannyBen))

## [v0.0.7](https://github.com/DannyBen/madness/tree/v0.0.7) (2016-06-13)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.0.6...v0.0.7)

**Implemented enhancements:**

- Add support for loading images [\#10](https://github.com/DannyBen/madness/issues/10)
- Make the server ignore certain folders [\#9](https://github.com/DannyBen/madness/issues/9)

**Merged pull requests:**

- Add support for static files + fixes [\#12](https://github.com/DannyBen/madness/pull/12) ([DannyBen](https://github.com/DannyBen))

## [v0.0.6](https://github.com/DannyBen/madness/tree/v0.0.6) (2016-06-12)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.0.5...v0.0.6)

**Implemented enhancements:**

- Auto show only file in a folder [\#7](https://github.com/DannyBen/madness/issues/7)
- Add ability to configure from a file [\#4](https://github.com/DannyBen/madness/issues/4)

**Merged pull requests:**

- Redirect when a folder contains only a single file [\#11](https://github.com/DannyBen/madness/pull/11) ([DannyBen](https://github.com/DannyBen))
- Allow config using .madness.yml [\#6](https://github.com/DannyBen/madness/pull/6) ([DannyBen](https://github.com/DannyBen))
- Remove code climate config [\#3](https://github.com/DannyBen/madness/pull/3) ([DannyBen](https://github.com/DannyBen))

## [v0.0.5](https://github.com/DannyBen/madness/tree/v0.0.5) (2016-06-12)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.0.4...v0.0.5)

**Merged pull requests:**

- Improve styling and SCSS [\#2](https://github.com/DannyBen/madness/pull/2) ([DannyBen](https://github.com/DannyBen))

## [v0.0.4](https://github.com/DannyBen/madness/tree/v0.0.4) (2016-06-11)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.0.3...v0.0.4)

**Merged pull requests:**

- Add code syntax highlighting and line numbering [\#1](https://github.com/DannyBen/madness/pull/1) ([DannyBen](https://github.com/DannyBen))

## [v0.0.3](https://github.com/DannyBen/madness/tree/v0.0.3) (2016-06-11)

[Full Changelog](https://github.com/DannyBen/madness/compare/v0.0.2...v0.0.3)

## [v0.0.2](https://github.com/DannyBen/madness/tree/v0.0.2) (2016-06-11)

[Full Changelog](https://github.com/DannyBen/madness/compare/45f1a5426408e92079df1d6afe4e9f62436bdd08...v0.0.2)
