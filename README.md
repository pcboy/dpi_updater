# DPI updater

## Introduction

Just a very simple script to generate android flashable zips changing the density of the lcd in the build.prop.
Some pre-generated zips for major DPIs are inside the examples/ folder.

## Requirements

* Ruby >= 1.9


## Installation

    git clone https://github.com/pcboy/dpi_updater && cd dpi_updater && bundle install

## Usage

    $> bundle exec./dpi_updater.rb DPI DESTINATION.zip
