Package.describe({
  name: 'council',
  version: '0.1.0'
});

Package.onUse(function (api) {
  api.versionsFrom('1.2.0.2');

  // Core dependencies.
  api.use([
    'coffeescript',
    'underscore',
    'accounts-password',
    'stylus'
  ]);

  // 3rd party dependencies.
  api.use([
    'kadira:flow-router@2.7.0',
    'kadira:blaze-layout@2.2.0',
    'peerlibrary:computed-field@0.3.0',
    'peerlibrary:reactive-field@0.1.0',
    'peerlibrary:assert@0.2.5',
    'materialize:materialize@0.97.1',
    'useraccounts:materialize@1.12.4',
    'useraccounts:flow-routing@1.12.4'
  ]);

  // Internal dependencies.
  api.use([
    'core',
    'api',
    'ui-components'
  ]);

  api.addFiles([
    'upvotable.coffee',
    'account/config.coffee',
    'account/form.coffee',
    'flow-router/root.html',
    'flow-router/root.coffee',
    'flow-router/layout.html',
    'flow-router/layout.coffee',
    'flow-router/layout.styl',
    'flow-router/header.html',
    'flow-router/header.coffee',
    'flow-router/footer.html',
    'flow-router/footer.coffee',
    'flow-router/not-found.html',
    'flow-router/not-found.coffee',
    'flow-router/icons.html',
    'discussion/list.html',
    'discussion/list.coffee',
    'discussion/new.html',
    'discussion/new.coffee',
    'discussion/display.html',
    'discussion/display.coffee',
    'comment/list.html',
    'comment/list.coffee',
    'comment/new.html',
    'comment/new.coffee',
    'point/list.html',
    'point/list.coffee',
    'point/new.html',
    'point/new.coffee',
    'motion/list.html',
    'motion/list.coffee',
    'motion/new.html',
    'motion/new.coffee',
    'motion/vote.html',
    'motion/vote.coffee',
    'motion/vote.styl'
  ], 'client');
});
