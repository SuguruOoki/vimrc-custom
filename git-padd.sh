SELECTED_FILE_TO_ADD="$(git status --porcelain | \
                            sed '/^[A|UU|M]/d' | \
                            peco | \
                            awk -F ' ' '{print $NF}')"
if [ -n "$SELECTED_FILE_TO_ADD" ]; then
    search_root=`git rev-parse --show-toplevel`
    files=`echo "$SELECTED_FILE_TO_ADD" | tr '\n' ' '`
    `cd ${search_root} && git add ${files}`
fi

echo "Added:"
for line in $SELECTED_FILE_TO_ADD
do
    echo $line
done
