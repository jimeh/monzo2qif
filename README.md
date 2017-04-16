# Monzo2QIF

Super-hacky and quickly thrown together Monzo to QIF exporter. Use at your own
risk.

I've put bare minimum amount of work needed into this project just to get it
working in a way that it does exactly what I want, and nothing more. This is
essentially experimental pre-alpha code.

The reason I rolled my own instead of using one of the existing Monzo QIF export
projects floating around on GitHub, is cause requirements were simpler:

- Set `payee` value based on Monzo transaction `description`. Meaning merchant
  info from Monzo is completely ignored.
- Set `memo` value based on Monzo transaction `notes`, nothing else. Other Monzo
  QIF export projects use the `memo` QIF field to add various pieces of extra
  info and metadata from Monzo. I don't care for it. But I do care for any
  custom notes I've manually added to a transaction in Monzo.

## Installation

```
gem install monzo2qif --pre
```

## Usage

```
Usage: monzo2qif [options]

Options:
  -t, --token=<s>            Monzo account token - https://developers.monzo.com/
  -u, --include-unsettled    Include unsettled transactions?
  -s, --start-date=<s>       Start date (optional)
  -e, --end-date=<s>         End date (optional)
  -o, --output-dir=<s>       Output directory (defaults to current working directory)

  -v, --version              Print version and exit
  -h, --help                 Show this message
```

## Todo

- Abandon this project if the official Monzo app for Android ever gets QIF
  export support.

## License

The gem is available as open source under the terms of
the [MIT License](http://opensource.org/licenses/MIT).
