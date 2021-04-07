# hls-playlist2one-ts

## Description

You can get combined into one ts file by http live streaming playlist file!

## Example

### Add permission into run file

```shell
chmod u+x ./run.sh
```

### Run

|option|about|
|---|---|
|-f(required)|playlist(m3u8) file path by absolute|
|-s(required)|ts file download base url|
|-o(option)|output path.(cannot slash char at last)|

```shell
./run.sh -f ./example.m3u8 -s htts://example.com
```