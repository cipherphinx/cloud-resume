describe('Resume Website', () => {
  beforeEach(() => {
    cy.visit('https://resume.arfeljunvelasco.live');
  });

  it('should display the correct page title', () => {
    cy.title().should('eq', 'Resume - Arfel Jun Velasco');
  });

  it('should navigate to different sections using the navbar', () => {
    cy.get('.navbar-nav')
      .contains('About')
      .click();
    cy.url().should('include', '#about');

    cy.get('.navbar-nav')
      .contains('Experience')
      .click();
    cy.url().should('include', '#experience');

    cy.get('.navbar-nav')
      .contains('Education')
      .click();
    cy.url().should('include', '#education');

    cy.get('.navbar-nav')
      .contains('Skills')
      .click();
    cy.url().should('include', '#skills');

    cy.get('.navbar-nav')
      .contains('Interests')
      .click();
    cy.url().should('include', '#interests');

    cy.get('.navbar-nav')
      .contains('Awards')
      .click();
    cy.url().should('include', '#awards');
  });

  it('should display the visit count', () => {
    cy.get('#visit_count').should('be.visible');
  });
});
