sanitize() {
    for filename in "$@"; do
        sanitized=$(echo "$filename" | sed 's/ä/ae/g; s/ö/oe/g; s/ü/ue/g; s/ß/ss/g; s/[^a-zA-Z0-9_. -]/_/g; s/ /_/g')
        if [ "$filename" != "$sanitized" ]; then
            echo "$filename -> $sanitized"
            mv "$filename" "$sanitized"
        fi
    done
}