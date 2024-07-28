modules="modules"

if [[ ! -d $modules ]]; then
    mkdir $modules
    cd $modules 
    mkdir ebs ec2 eip sg
fi

for dir in ./*; do
    cd $dir
    touch main.tf output.tf variable.tf
    cd ..
done

