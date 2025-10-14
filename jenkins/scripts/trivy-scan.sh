#!/bin/bash
trivy image $1 || echo "Trivy found issues (non-blocking)"

