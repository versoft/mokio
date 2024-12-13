for (let instance in CKEDITOR.instances) {
    if (CKEDITOR.instances.hasOwnProperty(instance)) {
        CKEDITOR.instances[instance].on('contentDom', function () {
          
            const $buttonElements = $(this.container.$).find('[class^="cke_button_"]');
          
            $buttonElements.each(function() {
              const $button = $(this);
              
              // Remove classes starting with "cke_button__"
              $button.attr('class', function(i, currentClass) {
                return currentClass.split(' ').filter(function(className) {
                  return !className.startsWith('cke_button__');
                }).join(' ');
              });
            });
        });
    }
}
