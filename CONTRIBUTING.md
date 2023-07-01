First of all. Thanks for contributing Flutter Vant UI!

This Project contains VantUI (core), Icons, Docs. For managing them we use `pnpm`.

## Prerequisites

- Flutter 3.3.10
- Dart 2.18.6
- Pnpm (`npm -g i pnpm`)

Use `fvm` for version managing is strongly recommended.

## Install Dependencies

Just simply execute: 
```bash
pnpm i
```

## Run Android demo

Connect an Android phone via adb. Or launch an AVD device.


Then:

```
pnpm dev:android
```


## FAQ

Q: Why not use `melos` for monorepo managing?

A: Melos is a good at monorepo tooling, that my team has used for over 1 years. However, it may have some bugs in recent versions that NOT be friendly for newbies. The `pnpm` will be temporary used until [Melos#511](https://github.com/invertase/melos/issues/511) is fixed.
