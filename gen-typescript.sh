# generate TypeScript Thrift files
node_modules/.bin/thrift-typescript --target thrift-server --rootDir . --sourceDir thrift --outDir bridget --strictUnions ../thrift/native.thrift

cd bridget

# create package.json
npm init -y
echo "//registry.npmjs.org/:_authToken=$NPM_TOKEN" >> ~/.npmrc
../node_modules/.bin/json -I -f package.json -e 'this.types="index.d.ts"'
../node_modules/.bin/json -I -f package.json -e 'this.name="@guardian/bridget"'

# generate JavaScript files with type declarations
../node_modules/.bin/tsc --init --declaration --target ES2016
../node_modules/.bin/tsc

# remove TypeScript files
ls | grep "^[A-Za-z]*.ts" | xargs rm

# use repo tag for version
git fetch --all
CURRENT_FULL_VERSION="$(git describe --tags --abbrev=0)"

# publish to npm
npm version ${CURRENT_FULL_VERSION}
npm publish --access public
