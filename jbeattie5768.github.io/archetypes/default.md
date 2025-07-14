+++
date = '{{ time.Now.Format "2006-01-02" }}'
draft = true
title = '{{ slicestr (replace .File.ContentBaseName "-" " ") 11 | title }}'
tags = []
+++

