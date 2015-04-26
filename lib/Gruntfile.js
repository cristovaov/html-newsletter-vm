module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
	uncss: {
	  dist: {
      options: {
        ignore: [
          ".ExternalClass",
          ".ExternalClass p",
          ".ExternalClass span",
          ".ExternalClass font",
          ".ExternalClass td",
          ".ExternalClass div",
          "#backgroundTable",
          "body.outlook p"
        ],
      },
	    files: {
	      'dist/css/tidy.css': ['email/boilerplate.html']
	    }
	  }
	},
	processhtml: {
    options: {
      includeBase: './'
    },
	  dist: {
	    files: {
	      'dist/email.html': ['email/boilerplate.html']
	    }
	  }
	},
	premailer: {
	  simple: {
	    options: {
        verbose: true,
        preserveStyles: true,
	    },
		files: {
		 'dist/email-inlined.html': ['dist/email.html']
	}
      }
     }
  });

grunt.loadNpmTasks('grunt-uncss');
grunt.loadNpmTasks('grunt-processhtml');
grunt.loadNpmTasks('grunt-premailer');

grunt.registerTask('email', ['uncss', 'processhtml', 'premailer']);
grunt.registerTask('inliner', ['premailer']);
grunt.registerTask('process', ['processhtml']);
grunt.registerTask('css', ['uncss']);
};

