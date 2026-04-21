#!/bin/bash

for imgPng in ./*.png 
 do
   convert $imgPng -compress lzw eps2:${imgPng%.*}.eps
done
