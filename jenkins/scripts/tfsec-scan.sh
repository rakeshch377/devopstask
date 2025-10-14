#!/bin/bash
tfsec $1 || echo "tfsec reported issues (non-blocking)"

