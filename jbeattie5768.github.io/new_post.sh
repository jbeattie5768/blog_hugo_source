#!/bin/bash

INPUT_TITLE=${1:-}

TITLE_TIDY="$(echo -n $INPUT_TITLE | tr [:space:] '-' | tr '_' '-' | tr '[:upper:]' '[:lower:]')"
PREFIX_DATE=`date "+%Y-%m-%d"`
SLUG="$PREFIX_DATE-$TITLE_TIDY"

echo $INPUT_TITLE
echo $TITLE_TIDY
echo $PREFIX_DATE
echo $SLUG
	
hugo new content posts/$SLUG/index.md
