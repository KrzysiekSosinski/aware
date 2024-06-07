import {When} from '@cucumber/cucumber';
import {

  hoverOverElement

} from './support/html-behavior';
import {ScenarioWorld} from './setup/world';
import {waitFor} from './support/wait-for-behavior';
import {getElementPath} from './support/web-element-helper';
import {ElementKey} from '../env/globals';

When(
  /^I hover the mouse over "([^"]*)" element$/,
  async function (this: ScenarioWorld, elementKey: ElementKey) {
    const {
      screen: {page},
      globalConfig
    } = this;

    const elementIdentifier = getElementPath(page, elementKey, globalConfig);

    await waitFor(async () => {
      const result = await page.waitForSelector(elementIdentifier, {
        state: 'visible'
      });
      if (result) {
        await hoverOverElement(page, elementIdentifier);
      }
      return result;
    });
  }
);
